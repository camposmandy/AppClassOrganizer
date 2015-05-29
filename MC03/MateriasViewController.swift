//
//  MateriasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData


class MateriasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var buttonAdcMateria: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var materia: Array<Materia>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materia?.count == 0 {
            return 1
        } else {
            return materia!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celMateria") as? MateriaTableViewCell
        
        if materia?.count != 0 {
            celula!.labelNome?.text = materia?[indexPath.row].nomeMateria
            tableView.userInteractionEnabled = true
            celula!.accessoryType = .DisclosureIndicator
        } else {
            celula?.labelNome.text = "Não há materias registradas"
            tableView.userInteractionEnabled = false
            celula?.accessoryType = .None
        }
        
        return celula!
    }
    
    override func viewDidAppear(animated: Bool) {
        reloadData()
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete{
//            MateriaManager.sharedInstance.deletar(materia!.removeAtIndex(indexPath.row))
//            MateriaManager.sharedInstance.salvar()
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VerMateria" {
            let VC = segue.destinationViewController as! VerMateriaTableTableViewController
            let cell = sender as? UITableViewCell
            let i = tableView.indexPathForCell(cell!)!.row
            VC.materiaAux = materia?[i]
        }
    }
    
    func reloadData(){
        materia = MateriaManager.sharedInstance.Materia()
        materia?.sort({ (first: Materia, second: Materia) -> Bool in
            return first.nomeMateria.localizedCaseInsensitiveCompare(second.nomeMateria) == NSComparisonResult.OrderedAscending
        })

        tableView.reloadData()
    }
}
