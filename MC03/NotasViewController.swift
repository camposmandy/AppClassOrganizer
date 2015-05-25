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
        
        return materiaAux.possuiNota.count
        //return notas!.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let materiaAux = materiaS![section]
        return materiaAux.nomeMateria
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celula = tableView.dequeueReusableCellWithIdentifier("celNota") as? NotasTableViewCell
        
        let materiaAux = materiaS![indexPath.section]
        
        var aux2 = materiaAux.possuiNota.allObjects as NSArray
        var nomeNota = (aux2.objectAtIndex(indexPath.row) as! Nota).tipoNota
        var nota = (aux2.objectAtIndex(indexPath.row) as! Nota).nota
        celula!.lblNomeNota.text = nomeNota
        celula!.lblNota.text = "\(nota)"
        return celula!
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
}
