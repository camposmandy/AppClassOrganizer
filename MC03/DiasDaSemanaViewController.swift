
// Organizado
// Rever código

//  DiasDaSemanaViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class DiasDaSemanaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variáveis
    
    var senderAdcViewController: AdicionarMateriaTableViewController?
    var senderEditViewController: EditarMateriaTableViewController?
    var diasSemana: Array<DiasSemana>?
    var semana = [false, false, false, false, false, false, false]
    var timer: NSTimer!
    var index: NSIndexPath!
    
    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        diasSemana = DiaSemanaManager.sharedInstance.DiasSemana()
    }
    
    // View Will Disappear
    override func viewWillDisappear(animated: Bool) {
        senderAdcViewController?.semana = semana
    }
    
    // MARK: - TableView
    // Número de seções
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Número de células
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diasSemana!.count
    }
    
    // Célula
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellSemana", forIndexPath: indexPath) as! DiasDaSemanaTableViewCell
        
        cell.lblDiaSemana.text = diasSemana?[indexPath.row].nomeDia
        
        
        return cell
    }
    
    // Célula selecionada
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark){
            cell?.accessoryType = UITableViewCellAccessoryType.None
            semana[indexPath.row] = false
        }
        else {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            semana[indexPath.row] = true
        }
        
        index = indexPath
        
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("clearSelectedCell"), userInfo: nil, repeats: false)
        
    }
    
    func clearSelectedCell() {
        tableView.deselectRowAtIndexPath(index, animated: true)
    }

    // MARK: - Actions
    
    @IBAction func buttonCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func butotnSalvar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
