//
//  FaltasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class FaltasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mat: Array<Materia>?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mat = MateriaManager.sharedInstance.Materia()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mat!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celula =  tableView.dequeueReusableCellWithIdentifier("celFaltas", forIndexPath: indexPath) as? FaltaTableViewCell

        celula!.lblMateria.text = mat?[indexPath.row].nomeMateria
        celula!.lblPercentualFalta.text = "\(mat?[indexPath.row].quantFaltas)"
        
        return celula!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var faltas = 0
        var selecionada = indexPath.row
        if let materia = mat?[indexPath.row] {
            faltas = materia.quantFaltas.integerValue + 1
            materia.quantFaltas = faltas
            MateriaManager.sharedInstance.salvar()
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
}
