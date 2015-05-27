//
//  VerMateriaTableTableViewController.swift
//  MC03
//
//  Created by João Marcos on 21/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class VerMateriaTableTableViewController: UITableViewController {

    
    @IBOutlet weak var lblNomeMateria: UILabel!
    @IBOutlet weak var lblNomeProfessor: UILabel!
    @IBOutlet weak var lblCargaHoraria: UILabel!
    @IBOutlet weak var lblDom: UILabel!
    @IBOutlet weak var lblSeg: UILabel!
    @IBOutlet weak var lblTer: UILabel!
    @IBOutlet weak var lblQua: UILabel!
    @IBOutlet weak var lblQui: UILabel!
    @IBOutlet weak var lblSex: UILabel!
    @IBOutlet weak var lblSab: UILabel!
    @IBOutlet weak var lblPercFaltas: UILabel!
    @IBOutlet weak var lblAulasFaltas: UILabel!
    
    var materia: Array<Materia>!
    var i: Int!
    var semana: Array<DiasSemana>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        preencherLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func preencherLabels(){
        
        materia = MateriaManager.sharedInstance.Materia()
        self.navigationItem.title = materia?[i].nomeMateria
        lblNomeMateria.text = materia[i].nomeMateria
        lblNomeProfessor.text = materia[i].nomeProfessor
        lblCargaHoraria.text = materia[i].cargaHoraria.stringValue
        lblPercFaltas.text = materia[i].faltas.stringValue
        var ix = materia[i].cargaHoraria.doubleValue * materia[i].faltas.doubleValue * 0.01
        var ii = Int(ix)
        lblAulasFaltas.text = "\(ii) Aulas"
        
        let materiaAux = materia[i]
        var dias = materiaAux.possuiSemana.allObjects as NSArray
        for i in 0...dias.count-1 {
            var nomeDia = (dias.objectAtIndex(i) as! DiasSemana).nomeDia
            if nomeDia == "Domingo" {
                lblDom.textColor = UIColor.greenColor()
            }
            if nomeDia == "Segunda" {
                lblSeg.textColor = UIColor.greenColor()
            }
            if nomeDia == "Terça" {
                lblTer.textColor = UIColor.greenColor()
            }
            if nomeDia == "Quarta" {
                lblQua.textColor = UIColor.greenColor()
            }
            if nomeDia == "Quinta" {
                lblQui.textColor = UIColor.greenColor()
            }
            if nomeDia == "Sexta" {
                lblSex.textColor = UIColor.greenColor()
            }
            if nomeDia == "Sábado" {
                lblSab.textColor = UIColor.greenColor()
            }
        }
    }
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
