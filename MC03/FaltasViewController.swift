
// Arrumado!
//

//  FaltasViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class FaltasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variáveis

    var todasMaterias: Array<Materia>?
    var materiasComFaltas: NSMutableArray = []
    
    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // View Will Appear
    override func viewWillAppear(animated: Bool) {
        carregarDados()
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
        let celula =  tableView.dequeueReusableCellWithIdentifier("celFaltas", forIndexPath: indexPath) as? FaltaTableViewCell

        if materiasComFaltas.count != 0 {
            if let materia = materiasComFaltas[indexPath.row] as? Materia {
                celula?.lblMateria.hidden = false
                celula?.lblPercentualFalta.hidden = false
                celula?.btnAdd.hidden = false
                celula?.btnMenos.hidden = false
                tableView.userInteractionEnabled = true
                
                celula?.materia = materia
                let faltasPermitidas = Int(materia.cargaHoraria.doubleValue * materia.faltas.doubleValue * 0.01)
                celula?.lblPercentualFalta.text = "Faltas \(materia.quantFaltas) de \(faltasPermitidas) permitidas"
                if Int(materia.quantFaltas) >= faltasPermitidas {
                    celula?.lblPercentualFalta.textColor = UIColor.redColor()
                } else if Int(materia.quantFaltas) >= faltasPermitidas-2 {
                    celula?.lblPercentualFalta.textColor = UIColor(red: 249/255, green: 105/255, blue: 14/255, alpha: 1)
                } else {
                    celula?.lblPercentualFalta.textColor = UIColor.blackColor()
                }
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
    
    func carregarDados () {
        todasMaterias = MateriaManager.sharedInstance.Materia()
        
        if let todasMat = todasMaterias {
            for m in todasMat {
                if m.controleFaltas == 1 {
                    materiasComFaltas.addObject(m)
                }
            }
        }
        tableView.reloadData()
    }
}
