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
    
    var materiaPrincipal: Array<Materia>?
    var diasSemana: Array<DiasSemana>?
    
    @IBAction func buttonNota(sender: AnyObject) {
    }
    
    @IBAction func buttonFalta(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificaPrimeiroAcesso()
        
        var date = NSDate()
        
        var dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "dd"
        var dayString = dayFormatter.stringFromDate(date)
        
        var monthFormatter = NSDateFormatter()
        monthFormatter.dateFormat = "MMMM"
        var monthString = monthFormatter.stringFromDate(date)
        
        labelDia.text = dayString
        labelMes.text = monthString
        
        tableView.delegate = self
        tableView.dataSource = self
        
        materiaPrincipal = MateriaManager.sharedInstance.Materia()
        diasSemana = DiaSemanaManager.sharedInstance.DiasSemana()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return diasSemana!.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dia = diasSemana![section]
        return dia.nomeDia
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let diaAux = diasSemana![section]
        var diaMat = diaAux.pertenceMateria.allObjects as NSArray
        return diaMat.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celPrincipal") as? PrincipalCell
        let diaAux = diasSemana![indexPath.section]
        var diaMat = diaAux.pertenceMateria.allObjects as NSArray
        
        celula!.lblMateria?.text = (diaMat.objectAtIndex(indexPath.row) as? Materia)?.nomeMateria
        celula!.lblMateria?.text = (diaMat.objectAtIndex(indexPath.row) as? Materia)?.nomeProfessor

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
        }
    }
}
