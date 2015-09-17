
// Organizado
// rever código

//  SelecionarMateriaViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class SelecionarMateriaNotaVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variáveis
    var materias: Array<Materia>?
    var select: NSIndexPath?
    var nota: Nota?
    var senderViewController: AdcNotaTableViewController?
    
    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        materias = MateriaManager.sharedInstance.Materia()
        materias?.sortInPlace({ (first: Materia, second: Materia) -> Bool in
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellMateriaNota", forIndexPath: indexPath) as! SelecionarMateriaNotaTBCell
        cell.lblNomeMateria.text = materias?[indexPath.row].nomeMateria
        return cell
    }
    
    // Célula selecionada
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(select != nil){
            let celula = tableView.cellForRowAtIndexPath(self.select!)
            celula?.accessoryType = .None
        }
        let celula2 = tableView.cellForRowAtIndexPath(indexPath)
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
