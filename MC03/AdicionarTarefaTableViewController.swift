//
//  AdicionarTarefaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class AdicionarTarefaTableViewController: UITableViewController {
   
    var alertMensagem = ""
    
    @IBOutlet weak var nomeTarefa: UITextField!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var opcao: UISwitch!
    
    @IBAction func btnSalvar(sender: AnyObject) {
        
        if verificaCampoVazio() {
        
        var tarefa = TarefaManager.sharedInstance.novaTarefa()
        
        tarefa.nomeTarefa = nomeTarefa.text
        tarefa.descricaoTarefa = descricao.text
//MATÉRIA
        var date = datePicker.date
        tarefa.dataEntrega = date

//OPÇÃO               tarefa.opcao = opcao.XXXX
        
        TarefaManager.sharedInstance.salvar()
        }
//        self.navigationController?.popViewControllerAnimated(true)

    }
    
    func verificaCampoVazio () -> Bool {
        
        var aux: Bool?
        
        var alertaMensagem = "Favor preencher o campo:\n"
        
        if (nomeTarefa.text == "") {
            alertaMensagem += "- Nome da Tarefa"
        }
        
        if (nomeTarefa.text != "") {
            alertaMensagem = "Tarefa Adicionada"
            aux = true
        } else {
            aux = false
        }
        
        let alerta: UIAlertController = UIAlertController(title: "Atenção!", message: alertaMensagem, preferredStyle: .Alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            if (aux == true) {
                self.navigationController?.popViewControllerAnimated(true)
            }
    }
        
        alerta.addAction(ok)
    
        self.presentViewController(alerta, animated: true, completion: nil)
        return aux!
    }
    
    @IBAction func btnCancelar(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
}

