
// Organizado!
// rever código

//  NotasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class NotasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variáveis

    var materias: Array<Materia>?
    var materiasComNota: Array<Materia>?
    var notas: Array<Nota>?
    
    var corAmarela = UIColor(red: 249/255, green: 191/255, blue: 59/255, alpha: 1)
    var corVerde = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)
    var corVermelha = UIColor(red: 242/255, green: 38/255, blue: 19/255, alpha: 1)
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAdicionar: UIBarButtonItem!
    @IBOutlet weak var btnEditar: UIBarButtonItem!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        carregarDados()
    }
    
    // MARK: - TableView
    // Numero de Seções
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if materiasComNota?.count == 0 || notas?.count == 0 {
            return 1
        } else {
            return materiasComNota!.count
        }
    }
    
    // Numero de Células na seção
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materiasComNota?.count == 0 || notas?.count == 0 {
            return 1
        } else {
            return materiasComNota![section].possuiNota.count
        }
    }
    
    // Título do Cabeçalho
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if materiasComNota?.count == 0 || notas?.count == 0 {
            return ""
        } else {
            let materiaAux = materiasComNota![section]
            return "• \(materiaAux.nomeMateria)"
        }
    }
    
    // Título do Rodapé
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if materiasComNota?.count == 0 || notas?.count == 0 {
            return ""
        } else {
            let materiaAux = materiasComNota![section]
            var notas = materiaAux.possuiNota.allObjects as NSArray
            var media = 0.0
            
            for i in notas {
                var nota = (i as! Nota).nota
                var peso = (i as! Nota).pesoNota
                var calc = nota.doubleValue * peso.doubleValue * 0.01
                media += calc
            }
            return "\t\t\t\t\t\t\t\t\t Média = \(media)"
        }
    }
    
    // Células
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celula = tableView.dequeueReusableCellWithIdentifier("celNota") as? NotasTableViewCell
        
        if materiasComNota?.count != 0 && notas?.count != 0 {
            
            celula!.lblNota.hidden = false
            celula!.lblNomeNota.hidden = false
            celula!.lblPeso.hidden = false
            celula!.textLabel?.hidden = true
            
            let materiaAux = materiasComNota![indexPath.section]
            
            var aux2 = materiaAux.possuiNota.allObjects as NSArray
            var nomeNota = (aux2.objectAtIndex(indexPath.row) as! Nota).tipoNota
            var nota = (aux2.objectAtIndex(indexPath.row) as! Nota).nota
            var peso = (aux2.objectAtIndex(indexPath.row) as! Nota).pesoNota
            var media = materiaAux.media.doubleValue
            
            celula!.lblNomeNota.text = nomeNota
            celula!.lblNota.text = "\(nota.doubleValue)"
            celula!.lblPeso.text = "\(peso)%"
            
            if nota.doubleValue < media - 0.1 {
              celula?.lblNota.textColor = corVermelha
            } else if nota.doubleValue == media - 0.1 || nota.doubleValue == media - 0.1 {
                celula?.lblNota.textColor = corAmarela
            } else {
                celula?.lblNota.textColor = corVerde
            }
        } else {
            celula!.lblNota.hidden = true
            celula!.lblNomeNota.hidden = true
            celula!.lblPeso.hidden = true
            celula!.textLabel?.hidden = false
            celula!.textLabel?.textColor = UIColor .grayColor()
            celula!.textLabel?.textAlignment = NSTextAlignment.Center
            
            if materias?.count == 0 {
                celula!.textLabel?.text = "Não há matérias cadastradas"
            }
            else if notas?.count == 0 {
                celula!.textLabel?.text = "Não há notas registradas"
            }
        }
        return celula!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            NotaManager.sharedInstance.deletar(self.notas![indexPath.row])
            NotaManager.sharedInstance.salvar()
            carregarDados()
            if notas?.count == 0 {
                tableView.editing = false
            }
            tableView.reloadData()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func btnEditar(sender: AnyObject) {
        if tableView.editing == true {
            tableView.editing = false
        } else {
            tableView.editing = true
        }
    }
    
    //MARK: - Outras Funções
    
    func carregarDados(){
        materias = MateriaManager.sharedInstance.Materia()
        notas = NotaManager.sharedInstance.Nota()
        
        materias?.sort({ (first: Materia, second: Materia) -> Bool in
            return first.nomeMateria.localizedCaseInsensitiveCompare(second.nomeMateria) == NSComparisonResult.OrderedAscending
        })
        
        if materias?.count != 0 {
            materiasComNota = Array<Materia>()
            for i in 0...materias!.count-1 {
                var aux = materias![i].possuiNota.allObjects as NSArray
                if aux.count != 0 {
                    materiasComNota?.append(materias![i])
                }
            }
            btnAdicionar.enabled = true
            if notas?.count == 0 {
                btnEditar.enabled = false
            } else {
                btnEditar.enabled = true
            }
        } else {
            btnAdicionar.enabled = false
            btnEditar.enabled = false
        }

        tableView.reloadData()
    }
}
