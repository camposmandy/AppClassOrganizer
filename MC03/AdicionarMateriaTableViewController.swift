//
//  AdicionarMateriaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class AdicionarMateriaTableViewController: UITableViewController {
    
    var alertMensagem = ""
    var teste = ""
    var materia: Materia!
    var nota: Nota?
    var diaSemana: Array<DiasSemana>?
    var semana: Array<Bool>?
    
    @IBOutlet weak var nomeMateria: UITextField!
    @IBOutlet weak var professor: UITextField!
    @IBOutlet weak var percentualFalta: UITextField!
    @IBOutlet weak var cargaHoraria: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func buttonCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        
        
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "esconderTeclado")
        //view.addGestureRecognizer(tap)
    }
    
    
    func esconderTeclado () {
        view.endEditing(true)
    }
    @IBAction func buttonSalvar(sender: AnyObject) {
        
        if verificaCampoVazio() {

            materia = MateriaManager.sharedInstance.novaMateria()
            
            materia.nomeMateria = nomeMateria.text
            materia.nomeProfessor = professor.text
            materia.cargaHoraria = cargaHoraria.text.toInt()!
            materia.faltas = percentualFalta.text.toInt()!
            materia.quantFaltas = 0
            
            diaSemana = DiaSemanaManager.sharedInstance.DiasSemana()
            
            for i in 0..<self.semana!.count {
                if semana![i] == true {
                    var dia = diaSemana?[i]
                    materia.adcDiaSemana(dia!)
                }
            }

            MateriaManager.sharedInstance.salvar()
        }
    }
    
    func verificaCampoVazio () -> Bool {
        
        var aux: Bool?
        
        var alertaMensagem = "Favor preencher o(s) campo(s):\n"
        
        if (nomeMateria.text == "") {
            alertaMensagem += "- Nome da Matéria\n"
        }
        
        if (professor.text == "") {
            alertaMensagem += "- Nome do Professor\n"
        }
        
        if (percentualFalta.text == "") {
            alertaMensagem += "- Percentual de Faltas\n"
        }
        
        if(cargaHoraria.text == "") {
            alertaMensagem += "- Carga Horaria\n"
        }
        
        if(nomeMateria.text != "" && professor.text != "" && percentualFalta.text != "" && cargaHoraria.text != ""){
            alertaMensagem = "Matéria Adicionada"
            aux = true
        }else{
            aux = false
        }
            
        let alerta: UIAlertController = UIAlertController(title: "Atenção!", message: alertaMensagem, preferredStyle: .Alert)
        
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
                    proxVC.senderViewController = self
            }
        }
    }
}