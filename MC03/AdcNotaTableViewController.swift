
// Organizado
// Rever código

//  AdcNotaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 25/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class AdcNotaTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Outlets

    @IBOutlet weak var lblMateria: UILabel!
    @IBOutlet weak var textFieldPesoNota: UITextField!
    @IBOutlet weak var textFieldTipoNota: UITextField!
    @IBOutlet weak var textFieldNota: UITextField!
    
    // MARK: - Variáveis
    
    var nota: Nota!
    var materia: Materia?

    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldTipoNota.delegate = self
        textFieldPesoNota.delegate = self
        textFieldNota.delegate = self
    }
    
    // View Will Appear
    override func viewWillAppear(animated: Bool) {
        if materia != nil {
            lblMateria.text = materia?.nomeMateria
        }
    }
    
    // Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selcMateria" {
            if let vc = segue.destinationViewController as? SelecionarMateriaNotaVC {
                vc.senderViewController = self
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func buttonCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func buttonSalvar(sender: AnyObject) {
        if verificaCamposVazio(){
            nota = NotaManager.sharedInstance.novaNota()
            if let _ = materia {
                nota.tipoNota = textFieldTipoNota.text!
                nota.pesoNota = Int(textFieldPesoNota.text!)!
                nota.nota = (textFieldNota.text! as NSString).doubleValue
                nota.pertenceMateria = materia!
                materia?.adcNota(nota)
                
                NotaManager.sharedInstance.salvar()
            }
        }
    }
    
    // MARK: - Outras
    
    func verificaCamposVazio() -> Bool{
        var aux: Bool?
        var alert = false
        var alertaM = ""
        var alertaT = "Atenção ⚠️"
        
        if (textFieldTipoNota.text == ""){
            alertaM += "- Preencha Tipo da nota\n"
            alert = true
        }
        
        if (textFieldPesoNota.text == ""){
            alertaM += "- Preencha o Peso da nota\n"
            alert = true
        }
        
        let auxPeso = (textFieldPesoNota.text! as NSString).doubleValue
        
        if auxPeso < 0 || auxPeso > 100 {
            alertaM += "- Peso de 0% a 100%\n"
            alert = true
        }
        
        if (textFieldNota.text == ""){
            alertaM += "- Preencha a Nota\n"
            alert = true
        }
        
        let auxNota = (textFieldNota.text! as NSString).doubleValue
        
        if auxNota < 0 || auxNota > 10 {
            alertaM += "- Nota de 0 a 10\n"
            alert = true
        }
        
        if (lblMateria.text == "") {
            alertaM += "- Selecione uma Matéria\n"
            alert = true
        }
        
        if alert == false {
            alertaM = "Nota adicionada ✔️"
            alertaT = "Pronto 😃"
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
    
    // MARK: - Teclado e TextField
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.textFieldTipoNota {
            self.textFieldPesoNota.becomeFirstResponder()
        } else if textField == self.textFieldPesoNota {
            self.textFieldNota.becomeFirstResponder()
        } else if textField == self.textFieldNota {
            textField.resignFirstResponder()
            self.performSegueWithIdentifier("selcMateria", sender: nil)
        }
        
        return true
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if textField == textFieldPesoNota || textField == textFieldNota {
            if string.characters.count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        return result
    }
}

