//
//  DiasDaSemanaViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class DiasDaSemanaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var senderViewController: AdicionarMateriaTableViewController?
    
    let diasSemana = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]
    var wek = [false, false, false, false, false, false, false]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func buttonCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func butotnSalvar(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diasSemana.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark){
            cell?.accessoryType = UITableViewCellAccessoryType.None
            wek[indexPath.row] = false
        }
        else {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            wek[indexPath.row] = true
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellSemana", forIndexPath: indexPath) as! DiasDaSemanaTableViewCell
        cell.lblDiaSemana.text = diasSemana[indexPath.row]
        
        return cell
    }
}
