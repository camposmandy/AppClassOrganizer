//
//  AdicionarTarefaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class AdicionarTarefaTableViewController: UITableViewController {
   
    @IBOutlet weak var nomeTarefa: UITextField!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var opcao: UISwitch!
    
    @IBAction func btnSalvar(sender: AnyObject) {
        var tarefa = TarefaManager.sharedInstance.novaTarefa()
        
        
        tarefa.nomeTarefa = nomeTarefa.text
        tarefa.descricaoTarefa = descricao.text
//MATÉRIA
        var date = datePicker.date
        tarefa.dataEntrega = date

//OPÇÃO               tarefa.opcao = opcao.XXXX
        
        TarefaManager.sharedInstance.salvar()
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    @IBAction func btnCancelar(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
}

