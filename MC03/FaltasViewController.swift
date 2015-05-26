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
    
    
    @IBAction func buttonMais(sender: AnyObject) {
    
        
        
    }
    
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
        celula!.lblPercentualFalta.text = "\(mat?[indexPath.row].faltas)"
        
        return celula!
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
}
