//
//  PrincipalViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class PrincipalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var labelDia: UILabel!
    @IBOutlet weak var labelMes: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var materiaPrincipal: Array<Materia>?
    
    @IBAction func buttonNota(sender: AnyObject) {
    }
    
    @IBAction func buttonFalta(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var date = NSDate()
        
        var dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "dd"
        var dayString = dayFormatter.stringFromDate(date)
        
        var monthFormatter = NSDateFormatter()
        monthFormatter.dateFormat = "MMMM"
        var monthString = monthFormatter.stringFromDate(date)
        
        labelDia.text = dayString
        labelMes.text = monthString
        
        tableView.delegate = self
        tableView.dataSource = self
        
        materiaPrincipal = MateriaManager.sharedInstance.Materia()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materiaPrincipal!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celPrincipal") as? PrincipalCell
        celula!.lblMateria?.text = materiaPrincipal?[indexPath.row].nomeMateria
        celula!.lblProfessor?.text = materiaPrincipal?[indexPath.row].nomeProfessor
        
        return celula!
    }
    
}
