//
//  AdcNotaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 25/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class AdcNotaTableViewController: UITableViewController {

    @IBOutlet weak var lblMateria: UILabel!
    @IBOutlet weak var textFieldPesoNota: UITextField!
    @IBOutlet weak var textFieldTipoNota: UITextField!
    @IBOutlet weak var textFieldNota: UITextField!
    
    var nota: Nota!
    var materia: Materia?
    
    @IBAction func buttonCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func buttonSalvar(sender: AnyObject) {
        if verificaCamposVazio(){
            nota = NotaManager.sharedInstance.novaNota()
            
        }
        if let n = materia {
            nota.tipoNota = textFieldTipoNota.text
            nota.pesoNota = textFieldPesoNota.text.toInt()!
            nota.nota = textFieldNota.text.toInt()! 
            nota.pertenceMateria = materia!
            materia?.adcNota(nota)
            
            NotaManager.sharedInstance.salvar()
        }
    }
    
    func verificaCamposVazio() -> Bool{
        var aux: Bool?
        var alertaM = "Por favor, preencha o campo: \n"
        
        if (textFieldPesoNota.text == ""){
            alertaM += "- Peso da nota \n"
        }
        
        if (textFieldTipoNota.text == ""){
            alertaM += "- Tipo da nota"
            aux = true
        }
        
        if (textFieldNota.text == ""){
            alertaM += "- Nota"
            aux = true
        }
        
        if(textFieldPesoNota.text != "" && textFieldPesoNota.text != "" && textFieldNota.text != ""){
            alertaM = "Nota adicionada"
            aux = true
        } else {
            aux = false
        }
        
        let alerta: UIAlertController = UIAlertController(title: "Alerta!", message: alertaM, preferredStyle: .Alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            if (aux == true) {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
        return aux!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if materia != nil {
            lblMateria.text = materia?.nomeMateria
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selcMateria" {
            if let vc = segue.destinationViewController as? SelecionarMateriaNotaVC {
                vc.senderViewController = self 
            }
        }
    }
}
