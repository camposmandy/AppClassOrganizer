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
    @IBOutlet weak var labelMateria: UILabel!
    
    
    
    override func viewDidLoad() {
        let data = NSDate()
        datePicker.minimumDate = data
        valorNotificacao = 1
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        nomeTarefa.resignFirstResponder()
        descricao.resignFirstResponder()
        labelMateria.resignFirstResponder()
        return true;
    }
    
    @IBAction func nomeTarefaTF(sender: AnyObject) {
        self.resignFirstResponder()
    }
    
    @IBAction func descricaoTF(sender: AnyObject) {
        self.resignFirstResponder()
    }
    
    var valorNotificacao: NSNumber = 0
    var tarefa: Tarefa!
    var materia: Materia?
    var semana: DiasSemana?
    
    @IBAction func btnSalvar(sender: AnyObject) {
        
        if verificaCampoVazio() {
            
            tarefa = TarefaManager.sharedInstance.novaTarefa()
            if let m = materia {
                tarefa.pertenceMateria = m
            }
            tarefa.nomeTarefa = nomeTarefa.text
            tarefa.descricaoTarefa = descricao.text
        
            
            var date = datePicker.date
            
            tarefa.dataEntrega = date
            tarefa.notificacao = valorNotificacao
            
            if(opcao.on) {
                let localNotification = UILocalNotification()
                //Mensagem
                localNotification.alertBody = "A tarefa \(nomeTarefa.text) deve ser entregue amanhã."
                
                
                //Som
                localNotification.soundName = UILocalNotificationDefaultSoundName
                
                
                //Incrementa o applicationIconBadgeNumber
                localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber+1
                
                
                
                localNotification.timeZone = NSTimeZone.defaultTimeZone()
                let umDiaMenos = 1
                tarefa.dataEntrega = date.dateByAddingTimeInterval(60*60*24*(-1))
                
                //localNotification.fireDate = NSDate(timeIntervalSinceNow: 6)
                localNotification.fireDate = tarefa.dataEntrega
                UIApplication.sharedApplication().applicationIconBadgeNumber = 0
                
                //Agenda a notificação
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            }
            
            
            TarefaManager.sharedInstance.salvar()
        }
    }
 
    @IBAction func estadoNotificacao(sender: AnyObject) {
        if (opcao.on) {
            valorNotificacao = 1
        } else {
            valorNotificacao = 0
        }
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
    
    override func viewDidAppear(animated: Bool) {
        if materia != nil {
            labelMateria.text = materia?.nomeMateria
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selecionarMateria" {
            if let vc = segue.destinationViewController as? SelecionarMateriaViewController {
                vc.senderViewController = self
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        nomeTarefa = nil
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        nomeTarefa = textField
    }
    
}


