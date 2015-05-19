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
    @IBOutlet weak var nomeMateria: UITextField!
    @IBOutlet weak var professor: UITextField!
    @IBOutlet weak var percentualFalta: UITextField!
    @IBOutlet weak var cargaHoraria: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func buttonCancelar(sender: AnyObject) {
    }
    @IBAction func buttonSalvar(sender: AnyObject) {
        
        verificaCampoVazio()
        
       // MateriaManager.sharedInstance.novaMateria()
        

        var materia = MateriaManager.sharedInstance.novaMateria()
        materia.nomeMateria = nomeMateria.text
        materia.nomeProfessor = professor.text
//        materia.faltas = percentualFalta.text // CONVERTER.
//        materia.cargaHoraria = cargaHoraria.text
        
        MateriaManager.sharedInstance.salvar()
        
        
        
    }
    
    
    func verificaCampoVazio () {
        
        if (nomeMateria.text == "") {
            
            alertMensagem = "Favor preencher o nome da matéria."
            
        }
        
        if (professor.text == "") {
            
            alertMensagem = "Favor preencher o nome do professor."
            
        }
        
        if (percentualFalta.text == "") {
            
            alertMensagem = "Favor preencher o percentual de faltas."
            
        }
        
        if(cargaHoraria.text == "") {
            
            alertMensagem = "Favor preencher a carga horária."
            
        }
        
        if(alertMensagem != ""){
            
        let alerta: UIAlertController = UIAlertController(title: "Atenção!", message: alertMensagem, preferredStyle: .Alert)
        
        let acao: UIAlertAction = UIAlertAction (title: "Ok", style: .Default) {
            action -> Void in
            println("Acão BOTAO OK.")
        }
        
        alerta.addAction(acao)
        
        self.presentViewController(alerta, animated: true, completion: nil)
            
        alertMensagem = ""
            
        }
    }
}
