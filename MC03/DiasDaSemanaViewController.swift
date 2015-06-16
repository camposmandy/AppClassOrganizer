//
//  DiasDaSemanaViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class DiasDaSemanaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var senderAdcViewController: AdicionarMateriaTableViewController?
    var senderEditViewController: EditarMateriaTableViewController?
    
    var diasSemana: Array<DiasSemana>?
    var semana = [false, false, false, false, false, false, false]
    
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
        
        diasSemana = DiaSemanaManager.sharedInstance.DiasSemana()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diasSemana!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark){
            cell?.accessoryType = UITableViewCellAccessoryType.None
            semana[indexPath.row] = false
        }
        else {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            semana[indexPath.row] = true
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellSemana", forIndexPath: indexPath) as! DiasDaSemanaTableViewCell

        cell.lblDiaSemana.text = diasSemana?[indexPath.row].nomeDia
        
        return cell
    }
    
    override func viewWillDisappear(animated: Bool) {
        senderAdcViewController?.semana = semana
//        
//        for i in 0..<semana.count {
//            if semana[i] == true {
//                var dia = diasSemana?[i]
//                self.senderViewController?.materia.adcDiaSemana(dia!)
//            }
//        }
    }
}
