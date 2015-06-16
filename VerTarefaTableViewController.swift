//
//  VerTarefaTableViewController.swift
//  MC03
//
//  Created by Leonardo Rodrigues de Morais Brunassi on 22/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class VerTarefaTableViewController: UITableViewController {
    
    
    @IBOutlet weak var lblNomeTarefa: UILabel!
    @IBOutlet weak var lblDescTarefa: UILabel!
    @IBOutlet weak var lblNomeMateria: UILabel!
    @IBOutlet weak var lblDataEntrega: UILabel!
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "teste" {
//            if let vc = segue.destinationViewController as? AdicionarTarefaTableViewController {
//                vc.senderViewController = self
//            }
//        }
//    }

    
    
//    @IBAction func botaoEditar(sender: AnyObject) {
//        var addTarefa = AdicionarTarefaTableViewController ()
//        addTarefa.nomeTarefa.text = lblNomeTarefa.text
//    }

    var tarefa: Array<Tarefa>!
    var i: Int!
    
    var materia: Array<Materia>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preencherLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func preencherLabels() {
        
        
        tarefa = TarefaManager.sharedInstance.Tarefa()
        self.navigationItem.title = tarefa?[i].nomeTarefa
        lblNomeTarefa.text = tarefa[i].nomeTarefa
        lblDescTarefa.text = tarefa[i].descricaoTarefa
        lblNomeMateria.text = tarefa[i].pertenceMateria.nomeMateria
    
       //lblNomeTarefa.text = tarefa[i].pertenceMateria
        
        var dataEntrega = NSDateFormatter()
        dataEntrega.dateFormat = "dd/MM/yyyy"
        var dataString = dataEntrega.stringFromDate(tarefa[i].dataEntrega)
        lblDataEntrega.text = dataString
        
    }
    
    func alert(){
        let alerta: UIAlertController = UIAlertController(title: "Atenção!", message: "Você tem certeza que deseja apagar esta tarefa?", preferredStyle: .Alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            TarefaManager.sharedInstance.deletar(self.tarefa[self.i])
            TarefaManager.sharedInstance.salvar()
            self.navigationController?.popViewControllerAnimated(true)
        }
        alerta.addAction(ok)
        
        let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Default) { action -> Void in
        }
        alerta.addAction(cancelar)
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    @IBAction func buttonApagar(sender: AnyObject){
        alert()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editarTarefa" {
            let VC = segue.destinationViewController as! AdicionarTarefaTableViewController
            //VC.tarefa = tarefa
        }
    }
}


