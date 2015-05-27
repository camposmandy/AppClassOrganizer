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
    
}


