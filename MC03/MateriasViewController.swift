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
        
        materia = MateriaManager.sharedInstance.Materia()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materia!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celMateria") as? MateriaTableViewCell
        
        //        let materia = materias[indexPath.row]
        celula!.labelNome?.text = materia?[indexPath.row].nomeMateria
        
        return celula!
    }
    
    
}
