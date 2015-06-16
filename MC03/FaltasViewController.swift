//
//  FaltasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class FaltasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mat: Array<Materia>?
    
    //var faltas = 0

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mat = MateriaManager.sharedInstance.Materia()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mat?.count == 0 {
            return 1
        } else {
            return mat!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celula =  tableView.dequeueReusableCellWithIdentifier("celFaltas", forIndexPath: indexPath) as? FaltaTableViewCell

        if mat?.count != 0 {
            if let materia = mat?[indexPath.row] {
                celula?.lblMateria.hidden = false
                celula?.lblPercentualFalta.hidden = false
                celula!.btnAdd.hidden = false
                celula?.btnMenos.hidden = false
                tableView.userInteractionEnabled = true
                
                celula!.materia = materia
                celula!.lblMateria.text = materia.nomeMateria
                celula!.lblPercentualFalta.text = "\(materia.quantFaltas)"
            }
        } else {
            celula?.lblMateria.hidden = true
            celula?.lblPercentualFalta.hidden = true
            celula!.btnAdd.hidden = true
            celula?.btnMenos.hidden = true
            tableView.userInteractionEnabled = false

            celula?.textLabel?.text = "Não há matérias cadastradas"
            celula?.textLabel?.textColor = UIColor .grayColor()
            celula?.textLabel?.textAlignment = NSTextAlignment.Center
        }
        
        return celula!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var faltas = 0
//        var i: Int!
//        var carga = (mat?[indexPath.row].cargaHoraria)!.integerValue
//        var percentual = (mat?[indexPath.row].faltas)!.integerValue
//        
//        var total = (carga * percentual) / 100
//        
//        if let materia = mat?[indexPath.row] {
//            var aux = materia.quantFaltas.integerValue
//            if aux <= total {
//                faltas = aux + 1
//                materia.quantFaltas = faltas
//                
//                MateriaManager.sharedInstance.salvar()
//            }
//            
//            if aux == total {
//                let alerta : UIAlertController = UIAlertController(title: "Atenção!", message: "Você não pode faltar mais nessa matéria senão reprovará", preferredStyle: .Alert)
//                let canc: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in  
//                }
//                alerta.addAction(canc)
//                self.presentViewController(alerta, animated: true, completion: nil)
//            }
//            
//            if aux > total {
//                let alerta : UIAlertController = UIAlertController(title: "Atenção!", message: "Você já reprovou por falta nessa matéria 😢", preferredStyle: .Alert)
//                let cancelar: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
//                }
//                alerta.addAction(cancelar)
//                self.presentViewController(alerta, animated: true, completion: nil)
//            }
//        }
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func verificaFaltas(){
        var i: Int!
      var carga = (mat?[i].cargaHoraria)!.integerValue
      var percentual = (mat?[i].faltas)!.integerValue
        
        var total = (carga * percentual) / 100
    }
}
