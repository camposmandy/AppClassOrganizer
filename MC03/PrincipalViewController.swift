//
//  PrincipalViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class PrincipalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var labelDia: UILabel!
    @IBOutlet weak var labelMes: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNota: JMButton!
    @IBOutlet weak var btnFalta: JMButton!
    
    var myColor = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)
    
    var materiaPrincipal: Array<Materia>?
    var diasSemana: Array<DiasSemana>?

    var date: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController!.tabBar.tintColor = myColor
        verificaPrimeiroAcesso()
        
        date = NSDate()
        
        var dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "dd"
        var dayString = dayFormatter.stringFromDate(date)
        
        var monthFormatter = NSDateFormatter()
        monthFormatter.dateFormat = "MMMM"
        var monthString = monthFormatter.stringFromDate(date)

        labelDia.text = dayString
        labelMes.text = monthString
        
        btnFalta.setTitleColor(UIColor .grayColor(), forState: UIControlState.Disabled)
        btnNota.setTitleColor(UIColor .grayColor(), forState: UIControlState.Disabled)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        materiaPrincipal = MateriaManager.sharedInstance.Materia()
        diasSemana = DiaSemanaManager.sharedInstance.DiasSemana()
    }
    
    override func viewDidAppear(animated: Bool) {
        materiaPrincipal = MateriaManager.sharedInstance.Materia()
        diasSemana = DiaSemanaManager.sharedInstance.DiasSemana()
        
        if materiaPrincipal?.count == 0 {
            btnNota.enabled = false
            btnFalta.enabled = false
            btnNota.borderColor = UIColor .grayColor()
            btnFalta.borderColor = UIColor .grayColor()
        } else {
            btnNota.enabled = true
            btnFalta.enabled = true
            btnNota.borderColor = myColor
            btnFalta.borderColor = myColor
        }
        
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let diaSemana = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date).weekday
        switch diaSemana {
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let diaSemana = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date).weekday
        let diaAux = diasSemana![diaSemana-1]
        var diaMat = diaAux.pertenceMateria.allObjects as NSArray
        if diaMat.count != 0 {
            return diaMat.count
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celPrincipal") as? PrincipalCell
        let diaSemana = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date).weekday
        
        let diaAux = diasSemana![diaSemana-1]
        var diaMat = diaAux.pertenceMateria.allObjects as NSArray
        
        if diaMat.count != 0 {
            celula?.lblMateria.hidden = false
            celula?.lblProfessor.hidden = false
            celula?.lblPercentualFalta.hidden = false
            celula?.imagemIcone.hidden = false
            celula?.textLabel?.hidden = true
            
            celula!.lblMateria?.text = (diaMat.objectAtIndex(indexPath.row) as? Materia)?.nomeMateria
            celula!.lblProfessor?.text = "Prof. \((diaMat.objectAtIndex(indexPath.row) as! Materia).nomeProfessor)"
            if (diaMat.objectAtIndex(indexPath.row) as! Materia).controleFaltas == 1 {
                celula!.lblPercentualFalta?.text = "Faltas \((diaMat.objectAtIndex(indexPath.row) as! Materia).quantFaltas) de \((diaMat.objectAtIndex(indexPath.row) as! Materia).faltas) permitidas"
            } else {
                celula!.lblPercentualFalta?.text == ""
            }
        } else {
            celula?.lblMateria.hidden = true
            celula?.lblProfessor.hidden = true
            celula?.lblPercentualFalta.hidden = true
            celula?.imagemIcone?.hidden = true
            
            celula?.textLabel?.hidden = false
            
            celula?.textLabel?.text = "Sem Matérias 😁"
            celula?.textLabel?.textColor = UIColor .grayColor()
            celula?.textLabel?.textAlignment = NSTextAlignment.Center
        }

        return celula!
    }
    
    func verificaPrimeiroAcesso() {
        var userDefault = NSUserDefaults()
        var acesso = userDefault.objectForKey("Acesso") as? String
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
        let alerta: UIAlertController = UIAlertController(title: "Bem-Vindo", message: "Para começar, adicione matérias, vá em Mais > Matérias > + ", preferredStyle: .Alert)
        
        let ok:  UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
        }
        
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var maisFalta = UITableViewRowAction(style: .Normal, title: "+ Falta") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            self.performSegueWithIdentifier("showFaltas", sender: nil)
        }
        
        var maisNota = UITableViewRowAction(style: .Normal, title: "+ Nota") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            // 
        }
        
        maisFalta.backgroundColor = UIColor.blueColor()
        maisNota.backgroundColor = UIColor.greenColor()
        
        return [maisFalta, maisNota]
    }
}
