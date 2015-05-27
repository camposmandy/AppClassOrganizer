//
//  AdcNotaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 25/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class AdcNotaTableViewController: UITableViewController, UITextFieldDelegate {

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
        var alert = false
        var alertaM = ""
        var alertaT = "Atenção"
        
        if (textFieldPesoNota.text == ""){
            alertaM += "- Preencha o Peso da nota\n"
            alert = true
        }
        
        if (textFieldTipoNota.text == ""){
            alertaM += "- Preencha Tipo da nota\n"
            alert = true
        }
        
        if (textFieldNota.text == ""){
            alertaM += "- Preencha a Nota\n"
            alert = true
        }
        
        if (lblMateria.text == "") {
            alertaM += "- Selecione uma Matéria\n"
            alert = true
        }
        
        var auxNota = (textFieldNota.text as NSString).doubleValue

        if auxNota < 0 || auxNota > 10 {
            alertaM += "- Nota de 0 a 10"
            alert = true
        }
        
        if alert == false {
            alertaM = "Nota adicionada"
            alertaT = "Pronto"
            aux = true
        } else {
            aux = false
        }
        
        let alerta: UIAlertController = UIAlertController(title: alertaT, message: alertaM, preferredStyle: .Alert)
        
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
        
        textFieldPesoNota.delegate = self
        textFieldNota.delegate = self
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if textField == textFieldPesoNota || textField == textFieldNota {
            if count(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        return result
    }
}
