//

// Arrumado!!!!!!!

//  VerTarefaTableViewController.swift
//  MC03
//
//  Created by Leonardo Rodrigues de Morais Brunassi on 22/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class VerTarefaTableViewController: UITableViewController {
    
    //MARK: - Varáveis
    
    var materia: Array<Materia>?
    var tarefas: Array<Tarefa>!
    var i: Int!

    //MARK: - Outlets
    
    @IBOutlet weak var lblNomeTarefa: UILabel!
    @IBOutlet weak var lblDescTarefa: UILabel!
    @IBOutlet weak var lblNomeMateria: UILabel!
    @IBOutlet weak var lblDataEntrega: UILabel!
    @IBOutlet weak var swOpcao: UISwitch!
    @IBOutlet weak var btnConcluir: UIButton!

    //MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        preencherLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editarTarefa" {
            let VC = segue.destinationViewController as! AdicionarTarefaTableViewController
            VC.tarefa = tarefas?[i]
        }
    }
    
    // MARK: - Actions
    
    @IBAction func buttonApagar(sender: AnyObject){
        alertaApagar()
    }
    
    @IBAction func btnConcluir(sender: AnyObject) {
        if tarefas[i].statusTarefa == 1 {
            alertaConcluir()
        }
        else {
            alertaConcluido()
        }
    }
    
    // MARK: - Outras Funções

    func preencherLabels() {
        tarefas = TarefaManager.sharedInstance.Tarefa()
        
        self.navigationItem.title = tarefas?[i].nomeTarefa
        
        lblNomeTarefa.text = tarefas?[i].nomeTarefa
        lblDescTarefa.text = tarefas?[i].descricaoTarefa
        lblNomeMateria.text = tarefas?[i].pertenceMateria.nomeMateria

        var dataEntrega = NSDateFormatter()
        dataEntrega.dateFormat = "dd/MM/yyyy"
        
        var dataString = dataEntrega.stringFromDate(tarefas[i].dataEntrega)
        lblDataEntrega.text = dataString
        
        if tarefas?[i].notificacao == 1 {
            swOpcao.setOn(true, animated: true)
        } else {
            swOpcao.setOn(false, animated: true)
        }
    }
    
    func alertaApagar(){
        let alerta: UIAlertController = UIAlertController(title: "Atenção!",
                                                          message: "Você tem certeza que deseja apagar esta tarefa?",
                                                          preferredStyle: .Alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok",
                                              style: .Default) { action -> Void in
            TarefaManager.sharedInstance.deletar(self.tarefas[self.i])
            TarefaManager.sharedInstance.salvar()
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar",
                                                    style: .Default) { action -> Void in }
        
        alerta.addAction(ok)
        alerta.addAction(cancelar)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }

    func alertaConcluir(){
        let alerta: UIAlertController = UIAlertController(title: "Atenção",
                                                          message: "Você tem certeza que concluiu esta tarefa?",
                                                          preferredStyle: .Alert)
        
        let sim: UIAlertAction = UIAlertAction(title: "Sim",
                                               style: .Default) { action -> Void in
                var t = self.tarefas[self.i]
                t.statusTarefa = 0
                TarefaManager.sharedInstance.salvar()
                self.navigationController?.popViewControllerAnimated(true)
        }
        
        let nao: UIAlertAction = UIAlertAction(title: "Não", style: .Default) { action -> Void in }
        
        alerta.addAction(nao)
        alerta.addAction(sim)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    func alertaConcluido() {
        let alerta: UIAlertController = UIAlertController(title: "Atenção",
            message: "Essa tarefa já foi concluída",
            preferredStyle: .Alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in }
        
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
}


