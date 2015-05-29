//
//  SelecionarMateriaViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class SelecionarMateriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var materia: Array<Materia>?
    var select: NSIndexPath?
    
    var tarefa: Tarefa?
    
    var senderViewController: AdicionarTarefaTableViewController?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        materia = MateriaManager.sharedInstance.Materia()
        materia?.sort({ (first: Materia, second: Materia) -> Bool in
            return first.nomeMateria.localizedCaseInsensitiveCompare(second.nomeMateria) == NSComparisonResult.OrderedAscending
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materia!.count 
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(select != nil){
            var celula = tableView.cellForRowAtIndexPath(self.select!)
            celula?.accessoryType = .None
        }
        var celula2 = tableView.cellForRowAtIndexPath(indexPath)
        celula2?.accessoryType = .Checkmark
        
        self.select = indexPath
        
        if let materia = materia?[indexPath.row] {
            if senderViewController != nil {
                senderViewController?.materia = materia
            }
            
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("celMateria", forIndexPath: indexPath) as! SelecionarMateriaTableViewCell
        cell.lblMateria.text = materia?[indexPath.row].nomeMateria
        return cell
    }
    
    override func viewDidDisappear(animated: Bool) {
        println("select = \(select?.row)")
    }
}
