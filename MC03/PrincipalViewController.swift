
// Arrumado e Organizado!
// sugestões de implementação

//  PrincipalViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class PrincipalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets

    @IBOutlet weak var labelDia: UILabel!
    @IBOutlet weak var labelMes: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelAdicionar: UILabel!
    // MARK: - Variáveis
    
    var appColor = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)
    var diasSemana: Array<DiasSemana>?
    var date: NSDate!
    var diaDaSemana = 0
    var materiasDoDia = NSArray()
    var materias: [Materia]?
    
    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController!.tabBar.tintColor = appColor
        labelAdicionar.hidden = true
        carregarDados()
        verificaPrimeiroAcesso()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // View Will Appear
    override func viewWillAppear(animated: Bool) {
        carregarDados()
        if materias?.count != 0 {
            let indexPath = NSIndexPath(forRow: 0, inSection: self.diaDaSemana-1)
            self.tableView.scrollToRowAtIndexPath(indexPath,
                atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        }
    }
    
    // Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "adcNotaMateria" {
            if let senderVC = segue.destinationViewController as? AdcNotaTableViewController {
                senderVC.materia = sender as? Materia
            }
        }
    }

    // MARK: - TableView
    // Número de seções
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if materias!.count != 0 {
            return (diasSemana?.count)!
        } else {
            return 1
        }
    }
    
    // Cabeçalho da Seção
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if materias?.count != 0 {
            switch section {
            case 0: return "Domingo"
            case 1: return "Segunda-Feira"
            case 2: return "Terça-Feira"
            case 3: return "Quarta-Feira"
            case 4: return "Quinta-Feira"
            case 5: return "Sexta-Feira"
            case 6: return "Sábado"
            default: return ""
            }
        } else {
            return ""
        }
        
    }
    
    // Número de células na seção
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materias!.count != 0 {
            if diasSemana![section].pertenceMateria.allObjects.count != 0 {
            return diasSemana![section].pertenceMateria.allObjects.count
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    // Célula
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let celula = tableView.dequeueReusableCellWithIdentifier("celPrincipal") as? PrincipalCell
        tableView.userInteractionEnabled = true
        celula?.userInteractionEnabled = true
        if diasSemana![indexPath.section].pertenceMateria.allObjects.count != 0 {
           let materia = diasSemana![indexPath.section].pertenceMateria.allObjects[indexPath.row] as! Materia
            
            if indexPath.section == diaDaSemana-1 {
                celula?.lblMateria.hidden = false
                celula?.lblProfessor.hidden = false
                celula?.lblPercentualFalta.hidden = false
                celula?.imagemIcone.hidden = false
                
                celula?.textLabel?.hidden = true
                
                celula?.lblMateria.text = materia.nomeMateria
                
                if materia.nomeProfessor != "" {
                    celula?.lblProfessor.text = "Prof. \(materia.nomeProfessor)"
                } else {
                    celula?.lblProfessor.text = ""
                }
                
                if materia.controleFaltas == 1 {
                    let faltasPermitidas = Int(materia.cargaHoraria.doubleValue * materia.faltas.doubleValue * 0.01)
                    celula!.lblPercentualFalta?.text = "Faltas \(materia.quantFaltas) de \(faltasPermitidas) permitidas"
                    if Int(materia.quantFaltas) >= faltasPermitidas {
                        celula?.lblPercentualFalta.textColor = UIColor.redColor()
                    } else if Int(materia.quantFaltas) >= faltasPermitidas-2 {
                        celula?.lblPercentualFalta.textColor = UIColor(red: 249/255, green: 105/255, blue: 14/255, alpha: 1)
                    } else {
                        celula?.lblPercentualFalta.textColor = UIColor.blackColor()
                    }
                } else {
                    celula!.lblPercentualFalta?.text == "sem controle de faltas"
                }
            } else {
                celula?.lblMateria.hidden = true
                celula?.lblProfessor.hidden = true
                celula?.lblPercentualFalta.hidden = true
                celula?.imagemIcone.hidden = true
                celula?.textLabel?.hidden = false
                celula?.textLabel?.textColor = UIColor .blackColor()
                celula?.textLabel?.text = " • \(materia.nomeMateria)"

            }
        } else {
            celula?.lblMateria.hidden = true
            celula?.lblProfessor.hidden = true
            celula?.lblPercentualFalta.hidden = true
            celula?.imagemIcone?.hidden = true
            
            celula?.textLabel?.hidden = false
            
            celula?.textLabel?.text = " Sem matérias"
            celula?.textLabel?.textColor = UIColor .grayColor()
            celula?.userInteractionEnabled = false
            if materias?.count == 0 {
                celula?.textLabel?.text = "Sem matérias cadastradas"
                celula?.textLabel?.textAlignment = NSTextAlignment.Center
                tableView.userInteractionEnabled = false
            }
            
        }
        
        return celula!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if diasSemana![indexPath.section].pertenceMateria.allObjects.count != 0 {
            if indexPath.section != diaDaSemana-1 {
                return 44
            } else {
                return 97
            }
        } else {
            return 44
        }
    }
    
    // Permite o swap na célula para opções
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    // Botões do swap na célula
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if diasSemana![indexPath.section].pertenceMateria.allObjects.count != 0 {
            let materia = diasSemana![indexPath.section].pertenceMateria.allObjects[indexPath.row] as! Materia
            
            // Botão + Nota
            let maisNota = UITableViewRowAction(style: .Normal, title: "+ Nota") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
                self.performSegueWithIdentifier("adcNotaMateria", sender: materia)
            }
            
            maisNota.backgroundColor = appColor
            
            if materia.controleFaltas == 1 {
                // Botão + Falta
                let maisFalta = UITableViewRowAction(style: .Normal, title: "+ Falta") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
                    let aux = materia.quantFaltas.integerValue + 1
                    materia.quantFaltas = aux
                    MateriaManager.sharedInstance.salvar()
                    tableView.reloadData()
                }
                
                maisFalta.backgroundColor = UIColor.grayColor()
                
                return [maisFalta, maisNota]
            } else {
                return [maisNota]
            }
        } else {
            return []
        }
    }

    // MARK: - Outras
    
    func verificaPrimeiroAcesso() {
        let userDefault = NSUserDefaults()
        let acesso = userDefault.objectForKey("Acesso") as? String
        if acesso == nil {
            var domingo: DiasSemana
            domingo = DiaSemanaManager.sharedInstance.novoDiaSemana()
            domingo.nomeDia = "Domingo"
            DiaSemanaManager.sharedInstance.salvar()
            
            var segunda: DiasSemana
            segunda = DiaSemanaManager.sharedInstance.novoDiaSemana()
            segunda.nomeDia = "Segunda"
            DiaSemanaManager.sharedInstance.salvar()
            
            var terca: DiasSemana
            terca = DiaSemanaManager.sharedInstance.novoDiaSemana()
            terca.nomeDia = "Terça"
            DiaSemanaManager.sharedInstance.salvar()
            
            var quarta: DiasSemana
            quarta = DiaSemanaManager.sharedInstance.novoDiaSemana()
            quarta.nomeDia = "Quarta"
            DiaSemanaManager.sharedInstance.salvar()
            
            var quinta: DiasSemana
            quinta = DiaSemanaManager.sharedInstance.novoDiaSemana()
            quinta.nomeDia = "Quinta"
            DiaSemanaManager.sharedInstance.salvar()
            
            var sexta: DiasSemana
            sexta = DiaSemanaManager.sharedInstance.novoDiaSemana()
            sexta.nomeDia = "Sexta"
            DiaSemanaManager.sharedInstance.salvar()
            
            var sabado: DiasSemana
            sabado = DiaSemanaManager.sharedInstance.novoDiaSemana()
            sabado.nomeDia = "Sábado"
            DiaSemanaManager.sharedInstance.salvar()
            
            userDefault.setObject("JaAcessou", forKey: "Acesso")
            
            alertaPrimeiraVez()
        }
    }
    
    func alertaPrimeiraVez() {
        let alerta: UIAlertController = UIAlertController(title: "Bem-Vindo",
                                                        message: "Para começar, adicione matérias, vá em Mais > Matérias > + ",
                                                 preferredStyle: .Alert)
        
        let ok:  UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in }
        
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    func carregarDados() {
        diasSemana = DiaSemanaManager.sharedInstance.DiasSemana()
        materias = MateriaManager.sharedInstance.Materia()
        
        date = NSDate()
        diaDaSemana = NSCalendar.currentCalendar().components(NSCalendarUnit.Weekday, fromDate: date).weekday
        //materiasDoDia = diasSemana![diaDaSemana-1].pertenceMateria.allObjects as NSArray
        
        let dayFormatter = NSDateFormatter()
        let monthFormatter = NSDateFormatter()
        
        dayFormatter.dateFormat = "dd"
        monthFormatter.dateFormat = "MMMM"
        
        let dayString = dayFormatter.stringFromDate(date)
        let monthString = monthFormatter.stringFromDate(date)
        
        labelDia.text = dayString
        labelMes.text = monthString
        
        if materias?.count == 0 {
            labelAdicionar.hidden = false
        } else {
            labelAdicionar.hidden = true
        }
        tableView.reloadData()
    }
}
