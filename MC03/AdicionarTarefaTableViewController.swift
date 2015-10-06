
// Organizado!
// Falta arrumar e conferir o código

//  AdicionarTarefaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class AdicionarTarefaTableViewController: UITableViewController, UITextFieldDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var nomeTarefa: UITextField!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var opcao: UISwitch!
    @IBOutlet weak var labelMateria: UILabel!
    
    // MARK: - Variáveis
    
    var valorNotificacao: NSNumber = 0
    var tarefa: Tarefa!
    var materia: Materia?
    var semana: DiasSemana?
    var editando = false
    var alertMensagem = ""
    var index: NSIndexPath?
    
    // MARK: - View
    
    override func viewDidLoad() {
        let data = NSDate()
        
        nomeTarefa.delegate = self
        descricao.delegate = self
        
        if let t = tarefa {
            editando = true
            self.navigationItem.title = "Editar Tarefa"
            nomeTarefa.text = t.nomeTarefa
            descricao.text = t.descricaoTarefa
            datePicker.date = t.dataEntrega
            labelMateria.text = "\(t.pertenceMateria.nomeMateria)"
            if tarefa.notificacao == 0 {
                opcao.setOn(false, animated: false)
                valorNotificacao = 0
            } else {
                opcao.setOn(true, animated: false)
                valorNotificacao = 1
            }
        } else {
            editando = false
            datePicker.minimumDate = data
            valorNotificacao = 1
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if materia != nil {
            labelMateria.text = materia?.nomeMateria
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if index != nil {
            tableView.deselectRowAtIndexPath(index!, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selecionarMateria" {
            if let vc = segue.destinationViewController as? SelecionarMateriaViewController {
                vc.senderViewController = self
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func btnSalvar(sender: AnyObject) {
        if verificaCampoVazio() {
            if editando == false {
                tarefa = TarefaManager.sharedInstance.novaTarefa()
            }
            if let m = materia {
                tarefa.pertenceMateria = m
            }
            
            tarefa.nomeTarefa = nomeTarefa.text!
            
            if descricao.text != ""{
                tarefa.descricaoTarefa = descricao.text!
            } else {
                tarefa.descricaoTarefa = "Sem descrição"
            }
            
            tarefa.statusTarefa = 1
            
            let date = datePicker.date
            
            tarefa.dataEntrega = date
            tarefa.notificacao = valorNotificacao
            
            if(opcao.on) {
                let localNotification = UILocalNotification()
                //Mensagem
                localNotification.alertBody = "A tarefa \(nomeTarefa.text!) deve ser entregue amanhã."
                
                //Som
                localNotification.soundName = UILocalNotificationDefaultSoundName
                
                //Incrementa o applicationIconBadgeNumber
                localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber+1
                
                localNotification.timeZone = NSTimeZone.defaultTimeZone()
                //let umDiaMenos = 1
                tarefa.dataEntrega = date
                let tarefaNot = date.dateByAddingTimeInterval(60*60*24*(-1))
                
                //localNotification.fireDate = NSDate(timeIntervalSinceNow: 6)
                localNotification.fireDate = tarefaNot
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
    
    @IBAction func btnCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - TextField
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.nomeTarefa {
            self.descricao.becomeFirstResponder()
        } else if textField == self.descricao {
            textField.resignFirstResponder()
            self.performSegueWithIdentifier("selecionarMateria", sender: nil)
        }
        return true
    }
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        nomeTarefa = nil
//    }
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        nomeTarefa = textField
//    }
    
    // MARK: - Outras

    func verificaCampoVazio () -> Bool {
        var aux: Bool?
        var alert = false
        var alertaM = ""
        let alertaT = "Atenção ⚠️"
        
        if (nomeTarefa.text == "") {
            alertaM += "- Preencha o Nome da Tarefa\n"
            alert = true
        }
        
        if (labelMateria.text == ""){
            alertaM += "- Selecione uma Matéria\n"
            alert = true
        }
        
        if alert == false {
            self.navigationController?.popViewControllerAnimated(true)
            return true
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
}


