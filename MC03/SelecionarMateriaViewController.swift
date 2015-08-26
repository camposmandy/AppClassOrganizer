
// Organizado!
// Rever código

//  SelecionarMateriaViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class SelecionarMateriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variáveis
    
    var materias: Array<Materia>?
    var tarefa: Tarefa?
    var select: NSIndexPath?
    var senderViewController: AdicionarTarefaTableViewController?
    
    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        materias = MateriaManager.sharedInstance.Materia()
        
        materias?.sort({ (first: Materia, second: Materia) -> Bool in
            return first.nomeMateria.localizedCaseInsensitiveCompare(second.nomeMateria) == NSComparisonResult.OrderedAscending
        })
    }
    
    // MARK: - TableView
    // Número de seções
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Número de células
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias!.count 
    }
    
    // Célula
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celMateria", forIndexPath: indexPath) as! SelecionarMateriaTableViewCell
        
        cell.lblMateria.text = materias?[indexPath.row].nomeMateria
        
        return cell
    }
    
    // Selecionar Célula
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(select != nil){
            var celula = tableView.cellForRowAtIndexPath(self.select!)
            celula?.accessoryType = .None
        }
        var celula2 = tableView.cellForRowAtIndexPath(indexPath)
        celula2?.accessoryType = .Checkmark
        
        self.select = indexPath
        
        if let materia = materias?[indexPath.row] {
            if senderViewController != nil {
                senderViewController?.materia = materia
            }
        }
        
        navigationController?.popViewControllerAnimated(true)
    }
}
