//
//  NotasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class NotasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var materiaS: Array<Materia>?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        materiaS = MateriaManager.sharedInstance.Materia()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return materiaS!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let materiaAux = materiaS![section]
        //if materiaAux.possuiNota.count == 0 {
        //    return 1
        //} else {
            return materiaAux.possuiNota.count
        //}
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let materiaAux = materiaS![section]
        return materiaAux.nomeMateria
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let materiaAux = materiaS![section]
        var notas = materiaAux.possuiNota.allObjects as NSArray
        var media = 0.0
        
        for i in notas {
            var nota = (i as! Nota).nota
            var peso = (i as! Nota).pesoNota
            var calc = nota.doubleValue * peso.doubleValue * 0.01
            media += calc
        }
        
        return "\t\t\t\t\t\t\t\t\tMédia = \(media)"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celula = tableView.dequeueReusableCellWithIdentifier("celNota") as? NotasTableViewCell
        
        let materiaAux = materiaS![indexPath.section]
        
        var aux2 = materiaAux.possuiNota.allObjects as NSArray
        var nomeNota = (aux2.objectAtIndex(indexPath.row) as! Nota).tipoNota
        var nota = (aux2.objectAtIndex(indexPath.row) as! Nota).nota
        var peso = (aux2.objectAtIndex(indexPath.row) as! Nota).pesoNota
        
        celula!.lblNomeNota.text = nomeNota
        celula!.lblNota.text = "\(nota.doubleValue)"
        celula!.lblPeso.text = "\(peso)%"
        
        return celula!
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
}
