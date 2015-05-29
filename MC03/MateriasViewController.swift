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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materia!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celMateria") as? MateriaTableViewCell
        celula!.labelNome?.text = materia?[indexPath.row].nomeMateria
        
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
            //VC.i = tableView.indexPathForCell(cell!)!.row
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
