
// Organizado
// Rever código, e a parte de edição tableview (comentado)

//  MateriasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class MateriasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var buttonAdcMateria: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variáveis
    
    var materia: Array<Materia>?
    var index: NSIndexPath?
    
    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // View Will Appear
    override func viewWillAppear(animated: Bool) {
        reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        if index != nil {
            tableView.deselectRowAtIndexPath(index!, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath
    }
    
    // Prepare For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VerMateria" {
            let VC = segue.destinationViewController as! VerMateriaTableTableViewController
            let cell = sender as? UITableViewCell
            let i = tableView.indexPathForCell(cell!)!.row
            VC.materia = materia?[i]
        }
    }
    
    // MARK: - TableView
    // Número de Seções
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Número de Células
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materia?.count == 0 {
            return 1
        } else {
            return materia!.count
        }
    }
    
    // Célula
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celMateria") as? MateriaTableViewCell
        
        if materia?.count != 0 {
            celula?.labelNome.hidden = false
            celula?.textLabel?.hidden = true
            celula!.labelNome?.text = materia?[indexPath.row].nomeMateria
            tableView.userInteractionEnabled = true
            celula!.accessoryType = .DisclosureIndicator
        } else {
            celula?.labelNome.hidden = true
            celula?.textLabel?.hidden = false
            celula?.textLabel?.text = "Não há materias registradas"
            celula!.textLabel?.textColor = UIColor .grayColor()
            celula!.textLabel?.textAlignment = NSTextAlignment.Center
            
            tableView.userInteractionEnabled = false
            celula?.accessoryType = .None
        }
        
        return celula!
    }
    
    // Editar
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
        MateriaManager.sharedInstance.deletar(self.materia![indexPath.row])
        MateriaManager.sharedInstance.salvar()
        tableView.reloadData()
        reloadData()
        }
    }

//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//        
//        let apagar = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Apagar") { (action, indexPath) -> Void in
//                    MateriaManager.sharedInstance.deletar(indexPath.ro)(indexPath.row as! Int)
//                    MateriaManager.sharedInstance.salvar()
//        }
//    }
//

    // MARK: - Outras
    
    func reloadData(){
        materia = MateriaManager.sharedInstance.Materia()
        materia?.sortInPlace({ (first: Materia, second: Materia) -> Bool in
            return first.nomeMateria.localizedCaseInsensitiveCompare(second.nomeMateria) == NSComparisonResult.OrderedAscending
        })

        tableView.reloadData()
    }
}
