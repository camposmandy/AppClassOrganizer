//
//  NotasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class NotasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var materia: Array<Materia>?
    var materiaComNota: Array<Materia>!
    var notas: Array<Nota>!
    
    var corAmarela = UIColor(red: 249/255, green: 191/255, blue: 59/255, alpha: 1)
    var corVerde = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)
    var corVermelha = UIColor(red: 242/255, green: 38/255, blue: 19/255, alpha: 1)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAdicionar: UIBarButtonItem!
    @IBOutlet weak var btnEditar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        materia = MateriaManager.sharedInstance.Materia()
        notas = NotaManager.sharedInstance.Nota()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if materia?.count == 0 || notas?.count == 0 {
            return 1
        } else {
            return materia!.count
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materia?.count == 0 || notas.count == 0 {
            return 1
        } else {
            let materiaAux = materia![section]
            return materiaAux.possuiNota.count
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if materia?.count == 0 || notas.count == 0 {
            return ""
        } else {
            let materiaAux = materia![section]
            return "• \(materiaAux.nomeMateria)"
        }
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if materia?.count == 0 || notas.count == 0 {
            return ""
        } else {
            let materiaAux = materia![section]
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celula = tableView.dequeueReusableCellWithIdentifier("celNota") as? NotasTableViewCell
        
        if materia?.count != 0 && notas.count != 0 {
            
            celula!.lblNota.hidden = false
            celula!.lblNomeNota.hidden = false
            celula!.lblPeso.hidden = false
            celula!.textLabel?.hidden = true
            
            let materiaAux = materia![indexPath.section]
            
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
            if notas.count == 0 {
                celula?.textLabel?.text = "Sem notas registradas"
            } else {
                celula?.textLabel?.text = "Não há materias cadastradas"
            }
        }
        return celula!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            NotaManager.sharedInstance.deletar(self.notas![indexPath.row])
            NotaManager.sharedInstance.salvar()
            tableView.reloadData()
            reloadD()
        }
    }

    override func viewDidAppear(animated: Bool) {
      reloadD()
    }
    
    func reloadD(){
        materia = MateriaManager.sharedInstance.Materia()
        notas = NotaManager.sharedInstance.Nota()
        
        materia?.sort({ (first: Materia, second: Materia) -> Bool in
            return first.nomeMateria.localizedCaseInsensitiveCompare(second.nomeMateria) == NSComparisonResult.OrderedAscending
        })
        
        if materia?.count != 0 {
            materiaComNota = Array<Materia>()
            for i in 0...materia!.count-1 {
                var aux = materia![i].possuiNota.allObjects as NSArray
                if aux.count != 0 {
                    materiaComNota.append(materia![i])
                }
            }
            
            btnAdicionar.enabled = true
            if notas.count == 0 {
                btnEditar.enabled = false
            } else {
                btnEditar.enabled = true
            }
        } else {
            btnAdicionar.enabled = false
            btnEditar.enabled = false
        }
        
        materia = materiaComNota
        tableView.reloadData()
    }
}
