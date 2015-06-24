//
//  AdicionarMateriaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class AdicionarMateriaTableViewController: UITableViewController, UITextFieldDelegate {
    
    var alertMensagem = ""
    var teste = ""
    var materia: Materia!
    var nota: Nota?
    var diaSemana: Array<DiasSemana>?
    var semana = [false, false, false, false, false, false, false]

    
    @IBOutlet weak var nomeMateria: UITextField!
    @IBOutlet weak var professor: UITextField!
    @IBOutlet weak var percentualFalta: UITextField!
    @IBOutlet weak var cargaHoraria: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var media: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nomeMateria.resignFirstResponder()
        professor.resignFirstResponder()
        return true
    }
    
    @IBAction func buttonCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        nomeMateria.delegate = self
        professor.delegate = self
        percentualFalta.delegate = self
        cargaHoraria.delegate = self
        media.delegate = self
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "esconderTeclado")
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    func esconderTeclado () {
        view.endEditing(true)
    }
    
    @IBAction func buttonSalvar(sender: AnyObject) {
        if verificaCampoVazio() {

            materia = MateriaManager.sharedInstance.novaMateria()
            
            materia.nomeMateria = nomeMateria.text
            
            if professor.text != "" {
                materia.nomeProfessor = professor.text
            } else {
                materia.nomeProfessor = "Desconhecido"
            }
            
            materia.cargaHoraria = cargaHoraria.text.toInt()!
            materia.faltas = percentualFalta.text.toInt()!
            materia.quantFaltas = 0
            materia.media = (media.text as NSString).doubleValue
            
            diaSemana = DiaSemanaManager.sharedInstance.DiasSemana()
            
            for i in 0..<self.semana.count {
                if semana[i] == true {
                    var dia = diaSemana?[i]
                    materia.adcDiaSemana(dia!)
                }
            }
            MateriaManager.sharedInstance.salvar()
        }
    }
    
    func verificaCampoVazio () -> Bool {
        var aux: Bool?
        var alert = false
        var alertaM = ""
        var alertaT = "Atenção ⚠️"
        
        if (nomeMateria.text == "") {
            alertaM += "- Preencha o Nome da Matéria\n"
            alert = true
        }
        
        if (media.text == "") {
            alertaM += "- Preencha a nota da Matéria\n"
            alert = true
        }
        
        var auxMedia = (media.text as NSString).doubleValue
        
        if auxMedia < 0 || auxMedia > 10 {
            alertaM += "- Média de 0 a 10\n"
            alert = true
        }
        
        if (percentualFalta.text == "") {
            alertaM += "- Preencha Percentual de Faltas\n"
            alert = true
        }
        
        var auxPerFalta = (percentualFalta.text as NSString).doubleValue
        
        if auxPerFalta < 0 || auxPerFalta > 100 {
            alertaM += "- Peso de 0% a 100%\n"
            alert = true
        }
        
        
        if(cargaHoraria.text == "") {
            alertaM += "- Preencha a Carga Horaria\n"
            alert = true
        }
        
        if semana == [false, false, false, false, false, false, false] {
            alertaM += "- Escolha um dia da Semana"
            alert = true
        }
        
        if alert == false {
            alertaM = "Matéria Adicionada ✔️"
            alertaT = "Pronto 😃"
            aux = true
        }else{
            aux = false
        }
 
        let alerta: UIAlertController = UIAlertController(title: alertaT, message: alertaM, preferredStyle: .Alert)
        
        let ok:  UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            if (aux == true) {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
        return aux!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cellSemana" {
            if let proxVC = segue.destinationViewController as? DiasDaSemanaViewController {
                    proxVC.senderAdcViewController = self
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if textField == percentualFalta || textField == cargaHoraria || textField == media{
            if count(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        return result
    }
}