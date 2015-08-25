//

// ARRUMADO!!!!!!!


//  FaltasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class FaltasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variáveis

    var todasMaterias: Array<Materia>?
    var materiasComFaltas: NSMutableArray = []
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todasMaterias = MateriaManager.sharedInstance.Materia()
        carregaMaterias()
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - TableView
    
    // Número de Seções
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Número de Células
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if materiasComFaltas.count == 0 {
            return 1
        } else {
            return materiasComFaltas.count
        }
    }
    
    // Célula
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var celula =  tableView.dequeueReusableCellWithIdentifier("celFaltas", forIndexPath: indexPath) as? FaltaTableViewCell

        if todasMaterias?.count != 0 {
            if let materia = todasMaterias?[indexPath.row] {
                celula?.lblMateria.hidden = false
                celula?.lblPercentualFalta.hidden = false
                celula?.btnAdd.hidden = false
                celula?.btnMenos.hidden = false
                tableView.userInteractionEnabled = true
                
                celula?.materia = materia
                celula?.lblPercentualFalta.text = "\(materia.quantFaltas)"
                celula?.lblMateria.text = materia.nomeMateria
            }
        } else {
            celula?.lblMateria.hidden = true
            celula?.lblPercentualFalta.hidden = true
            celula?.btnAdd.hidden = true
            celula?.btnMenos.hidden = true
            tableView.userInteractionEnabled = false

            celula?.textLabel?.text = "Não há matérias cadastradas"
            celula?.textLabel?.textColor = UIColor .grayColor()
            celula?.textLabel?.textAlignment = NSTextAlignment.Center
        }
        
        return celula!
    }

    // Célula selecionada
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.reloadData()
    }
    
    // MARK: - Outras Funções
    
    func carregaMaterias () {
        if let todasMat = todasMaterias {
            for m in todasMat {
                if m.controleFaltas == 1 {
                    materiasComFaltas.addObject(m)
                }
            }
        }
    }
}
