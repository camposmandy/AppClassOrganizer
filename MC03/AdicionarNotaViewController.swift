//
//  AdicionarNotaViewController.swift
//  MC03
//
//  Created by João Marcos on 22/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class AdicionarNotaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var quantNotas: Int = 1
    var materia: Materia?
    var senderViewController: AdicionarMateriaTableViewController?
    var notasExistentes: Array<Nota>?
    
    var tipoNota: UITextField!
    var pesoNota: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var lblAdicionar: UILabel!
    @IBAction func stepperChange(sender: AnyObject) {
        quantNotas = Int(stepper.value)
        tableView.reloadData()
        insereNota();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notasExistentes = NotaManager.sharedInstance.Nota()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notasExistentes!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellAdicionarNota", forIndexPath: indexPath) as! AdicionarNotaTableViewCell
        cell.textFieldPesoNota.text = "\(notasExistentes?[indexPath.row].pesoNota)"
        cell.textFieldTipoNota.text = notasExistentes?[indexPath.row].tipoNota
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func insereNota() {
        var alertController = UIAlertController(title: "Nota", message: nil, preferredStyle: .Alert)
        
        let buttonOk: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) -> Void in
            var nota = NotaManager.sharedInstance.novaNota()
            nota.tipoNota = self.tipoNota!.text
            nota.pesoNota = self.pesoNota!.text.toInt()!
            NotaManager.sharedInstance.salvar()
            self.tableView.reloadData()
        }
        
        let buttonCancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (UIAlertAction) -> Void in}
        
        alertController.addAction(buttonOk)
        alertController.addAction(buttonCancel)
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Tipo da Nota"
            self.tipoNota = textField
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Peso da Nota"
            self.pesoNota = textField
        }
        
        self.presentViewController (alertController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
