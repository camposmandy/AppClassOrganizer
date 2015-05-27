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
    @IBAction func buttonEditarTarefa(sender: AnyObject) {
        tableView.editing = true;
    }
    
    
    var tarefa: Array<Tarefa>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tarefa = TarefaManager.sharedInstance.Tarefa()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefa!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celula = tableView.dequeueReusableCellWithIdentifier("celTarefa") as? TarefasTableViewCell
        
        
        celula!.lblNomeTarefa?.text = tarefa?[indexPath.row].nomeTarefa
        celula!.lbldataEntrega?.text = "\(tarefa?[indexPath.row].dataEntrega)"
        
        
        //PEGAR APENAS AS DUAS PRIMEIRAS LETRAS DA STRING!
        if (tarefa?[indexPath.row].nomeTarefa != "") {
        var nomeT = tarefa?[indexPath.row].nomeTarefa
        var pegaPrimeirasLetras = getSubstringUpToIndex(2, fromString: nomeT!).uppercaseString
        
        celula!.primeirasLetras?.text = pegaPrimeirasLetras
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
        
        return String(head) +
            getSubstringUpToIndex(index - 1, fromString: tail)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tarefa = TarefaManager.sharedInstance.Tarefa()
        tableView.reloadData()
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "verTarefa" {
            let VC = segue.destinationViewController as! VerTarefaTableViewController
            let cell = sender as? UITableViewCell
            VC.i = tableView.indexPathForCell(cell!)!.row
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete {
            TarefaManager.sharedInstance.deletar(tarefa![indexPath.row])
            TarefaManager.sharedInstance.salvar()
            tarefa?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            //tableView.reloadData()
            
        }
    }
    
}
