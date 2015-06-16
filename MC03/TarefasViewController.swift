//
//  TarefasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class TarefasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var buttonAdcTarefa: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonEditar: UIBarButtonItem!
    
    var materias: Array<Materia>?
    var tarefa: Array<Tarefa>?
    
    @IBAction func buttonEditarTarefa(sender: AnyObject) {
        if tableView.editing == true {
            self.tableView.editing == false
            buttonEditar.title = "Editar"
        } else {
            self.tableView.editing = true
            buttonEditar.title = "Feito"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tarefa = TarefaManager.sharedInstance.Tarefa()
        materias = MateriaManager.sharedInstance.Materia()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materias?.count == 0 || tarefa?.count == 0 {
            return 1
        } else {
            return tarefa!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celTarefa") as? TarefasTableViewCell
        if materias?.count != 0 && tarefa?.count != 0{
            
            if let t = tarefa?[indexPath.row] {
                celula!.lblNomeTarefa.hidden = false
                celula!.lbldataEntrega.hidden = false
                celula!.lblNomeMateria.hidden = false
                celula!.imageCheck.hidden = false
                celula!.accessoryType = .DisclosureIndicator
                tableView.userInteractionEnabled = true
                celula!.textLabel?.hidden = true
                
                celula!.lblNomeTarefa?.text = t.nomeTarefa
                celula!.lbldataEntrega?.text = "\(t.dataEntrega)"
                
                var dataEntrega = NSDateFormatter()
                dataEntrega.dateFormat = "dd/MM/yyyy"
                var dataString = dataEntrega.stringFromDate(t.dataEntrega)
                celula!.lbldataEntrega.text = "para o dia \(dataString)"
                celula!.lblNomeMateria?.text = "(\(t.pertenceMateria.nomeMateria))"
            }
            
            if (tarefa?[indexPath.row].nomeTarefa != "") {
                var nomeT = tarefa?[indexPath.row].nomeTarefa
                var pegaPrimeirasLetras = getSubstringUpToIndex(2, fromString: nomeT!).uppercaseString
            }
        } else {
            celula!.lblNomeTarefa.hidden = true
            celula!.lbldataEntrega.hidden = true
            celula!.lblNomeMateria.hidden = true
            celula!.imageCheck.hidden = true
            celula!.textLabel?.hidden = false
            celula!.accessoryType = .None
            tableView.userInteractionEnabled = false
            celula!.textLabel?.textColor = UIColor .grayColor()
            celula!.textLabel?.textAlignment = NSTextAlignment.Center
            
            if materias?.count == 0 {
                celula!.textLabel?.text = "Não há matérias cadastradas"
            } else {
                celula!.textLabel?.text = "Não há tarefas registradas"
            }
        }
        return celula!
    }

    func getSubstringUpToIndex(index: Int,
        fromString str: String) -> String
    {
        let (head, tail) = (str[str.startIndex], dropFirst(str))
        if index == 1 {
            return String(head)
        }
        return String(head) + getSubstringUpToIndex(index - 1, fromString: tail)
    }
    
    override func viewDidAppear(animated: Bool) {
        tarefa = TarefaManager.sharedInstance.Tarefa()
        materias = MateriaManager.sharedInstance.Materia()
        
        if materias?.count == 0 {
            buttonAdcTarefa.enabled = false
        } else {
            buttonAdcTarefa.enabled = true
        }
        
        tableView.reloadData()
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "verTarefa" {
            let VC = segue.destinationViewController as! VerTarefaTableViewController
            let cell = sender as? UITableViewCell
            VC.i = tableView.indexPathForCell(cell!)!.row
        }
    }
}
