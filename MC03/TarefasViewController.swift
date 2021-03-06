
// Organizado! 
// Rever comentários

//  TarefasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class TarefasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets

    @IBOutlet weak var buttonAdcTarefa: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonEditar: UIBarButtonItem!
    
    // MARK: - Variáveis
    
    var materias: Array<Materia>?
    var tarefas: Array<Tarefa>?
    var index: NSIndexPath?
    
    // MARK: - View
    
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // View will Appear
    override func viewWillAppear(animated: Bool) {
        carregarDados()
    }
    
    override func viewDidAppear(animated: Bool) {
        if index != nil {
            tableView.deselectRowAtIndexPath(index!, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath
    }
    
    // Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "verTarefa" {
            let VC = segue.destinationViewController as! VerTarefaTableViewController
            let cell = sender as? UITableViewCell
            VC.i = tableView.indexPathForCell(cell!)!.row
        }
    }
    
    // MARK: - TableView
    
    // Numero de seções
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Numero de células
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materias?.count == 0 || tarefas?.count == 0 {
            return 1
        } else {
            return tarefas!.count
        }
    }
    
    // Célula
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celTarefa") as? TarefasTableViewCell
        if materias?.count != 0 && tarefas?.count != 0{
            if let tarefa = tarefas?[indexPath.row] {
                celula!.lblNomeTarefa.hidden = false
                celula!.lbldataEntrega.hidden = false
                celula!.lblNomeMateria.hidden = false
                celula!.imageCheck.hidden = false
                celula!.textLabel?.hidden = true
                
                celula!.accessoryType = .DisclosureIndicator
                tableView.userInteractionEnabled = true
                
                celula!.lblNomeTarefa?.text = tarefa.nomeTarefa
                celula!.lbldataEntrega?.text = "\(tarefa.dataEntrega)"
                
                let dataEntrega = NSDateFormatter()
                dataEntrega.dateFormat = "dd/MM/yyyy"
                
                let dataString = dataEntrega.stringFromDate(tarefa.dataEntrega)
                celula!.lbldataEntrega.text = "para o dia \(dataString)"
                celula!.lblNomeMateria.text = "(\(tarefa.pertenceMateria.nomeMateria))"
                
                if tarefa.statusTarefa == 0 {
                    let  imgNok = UIImage(named: "ok.png")
                    celula!.imageCheck.image = imgNok
                } else {
                    let imgOk = UIImage(named: "nok.png")
                    celula!.imageCheck.image = imgOk
                }
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
    
    // MARK: - Actions
    
    @IBAction func buttonEditarTarefa(sender: AnyObject) {
        if tableView.editing == true {
            self.tableView.editing == false
            buttonEditar.title = "Editar"
        } else {
            self.tableView.editing = true
            buttonEditar.title = "Feito"
        }
    }
    
    // MARK: - Outras
    func carregarDados() {
        tarefas = TarefaManager.sharedInstance.Tarefa()
        materias = MateriaManager.sharedInstance.Materia()
        
        if materias?.count == 0 {
            buttonAdcTarefa.enabled = false
        } else {
            buttonAdcTarefa.enabled = true
        }
        
        tableView.reloadData()
    }
}
