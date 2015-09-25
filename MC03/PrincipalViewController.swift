
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
    
    // MARK: - Variáveis
    
    var appColor = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)
    var diasSemana: Array<DiasSemana>?
    var date: NSDate!
    var diaDaSemana = 0
    var materiasDoDia = NSArray()
    
    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController!.tabBar.tintColor = appColor
        verificaPrimeiroAcesso()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // View Will Appear
    override func viewWillAppear(animated: Bool) {
        carregarDados()
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
        return 1
    }
    
    // Cabeçalho da Seção
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch diaDaSemana {
            case 1: return "Domingo"
            case 2: return "Segunda-Feira"
            case 3: return "Terça-Feira"
            case 4: return "Quarta-Feira"
            case 5: return "Quinta-Feira"
            case 6: return "Sexta-Feira"
            case 7: return "Sábado"
            default: return ""
        }
    }
    
    // Número de células na seção
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materiasDoDia.count != 0 {
            return materiasDoDia.count
        } else {
            return 1
        }
    }
    
    // Célula
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let celula = tableView.dequeueReusableCellWithIdentifier("celPrincipal") as? PrincipalCell

        if materiasDoDia.count != 0 {
            let materia = materiasDoDia.objectAtIndex(indexPath.row) as? Materia
            
            celula?.lblMateria.hidden = false
            celula?.lblProfessor.hidden = false
            celula?.lblPercentualFalta.hidden = false
            celula?.imagemIcone.hidden = false
            
            celula?.textLabel?.hidden = true
            
            if let mat = materia {
                celula?.lblMateria.text = mat.nomeMateria
                
                if mat.nomeProfessor != "" {
                    celula?.lblProfessor.text = "Prof. \(mat.nomeProfessor)"
                } else {
                    celula?.lblProfessor.text = ""
                }
                
                if mat.controleFaltas == 1 {
                    celula!.lblPercentualFalta?.text = "Faltas \(mat.quantFaltas) de \(mat.faltas) permitidas"
                    // Implementar uma mudança de cor na label caso o numero de faltas esteja perto do limite
                } else {
                    celula!.lblPercentualFalta?.text == "sem controle de faltas"
                }
            }
        } else {
            celula?.lblMateria.hidden = true
            celula?.lblProfessor.hidden = true
            celula?.lblPercentualFalta.hidden = true
            celula?.imagemIcone?.hidden = true
            
            celula?.textLabel?.hidden = false
            
            celula?.textLabel?.text = "Sem aulas hoje"
            celula?.textLabel?.textColor = UIColor .grayColor()
            celula?.textLabel?.textAlignment = NSTextAlignment.Center
        }

        return celula!
    }
    
    // Permite o swap na célula para opções
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    // Botões do swap na célula
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let materia = materiasDoDia.objectAtIndex(indexPath.row) as? Materia
        
        // Botão + Nota
        let maisNota = UITableViewRowAction(style: .Normal, title: "+ Nota") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            self.performSegueWithIdentifier("adcNotaMateria", sender: materia)
        }
        
        maisNota.backgroundColor = appColor
        
        
        
        if materia?.controleFaltas == 1 {
            // Botão + Falta
            let maisFalta = UITableViewRowAction(style: .Normal, title: "+ Falta") { (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
                self.performSegueWithIdentifier("showFaltas", sender: nil)
            }
            
            maisFalta.backgroundColor = UIColor.grayColor()
            
            return [maisFalta, maisNota]
        } else {
            return [maisNota]
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
        
        date = NSDate()
        diaDaSemana = NSCalendar.currentCalendar().components(NSCalendarUnit.Weekday, fromDate: date).weekday
        materiasDoDia = diasSemana![diaDaSemana-1].pertenceMateria.allObjects as NSArray
        
        let dayFormatter = NSDateFormatter()
        let monthFormatter = NSDateFormatter()
        
        dayFormatter.dateFormat = "dd"
        monthFormatter.dateFormat = "MMMM"
        
        let dayString = dayFormatter.stringFromDate(date)
        let monthString = monthFormatter.stringFromDate(date)
        
        labelDia.text = dayString
        labelMes.text = monthString
        
        if materiasDoDia.count == 0 {
            tableView.userInteractionEnabled = false
        } else {
            tableView.userInteractionEnabled = true
        }
        
        tableView.reloadData()
    }
}
