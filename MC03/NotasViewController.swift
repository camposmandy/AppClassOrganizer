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

    var materia: Array<Materia>?
    var materiaComNota: Array<Materia>!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        materia = MateriaManager.sharedInstance.Materia()
        materia?.sort({ (first: Materia, second: Materia) -> Bool in
            return first.nomeMateria.localizedCaseInsensitiveCompare(second.nomeMateria) == NSComparisonResult.OrderedAscending
        })
        
        materiaComNota = Array<Materia>()
        for i in 0...materia!.count-1 {
            var aux = materia![i].possuiNota.allObjects as NSArray
            if aux.count != 0 {
                materiaComNota.append(materia![i])
            }
        }

        materia = materiaComNota
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return materia!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let materiaAux = materia![section]
        return materiaAux.possuiNota.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let materiaAux = materia![section]
        return materiaAux.nomeMateria
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let materiaAux = materia![section]
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
        
        let materiaAux = materia![indexPath.section]
        
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
