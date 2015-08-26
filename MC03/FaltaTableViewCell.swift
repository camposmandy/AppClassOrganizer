//
//  FaltaTableViewCell.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class FaltaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMateria: UILabel!
    @IBOutlet weak var lblPercentualFalta: JMLabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnMenos: UIButton!
    
    var materia: Materia?
    
    @IBAction func buttonMaisFalta(sender: AnyObject) {
        if let m = materia {
            var carga = (materia?.quantFaltas)!.integerValue
            var aux = m.quantFaltas.integerValue
            var faltas = 0

            faltas = aux + 1
            m.quantFaltas = faltas
            MateriaManager.sharedInstance.salvar()
            }
        updateUI()
    }
    
    @IBAction func buttonMenosFalta(sender: AnyObject) {
        if let m = materia {
            var aux = m.quantFaltas.integerValue
            var faltas = 0
            if aux == 0 {
                
            } else {
            faltas = aux - 1
            m.quantFaltas = faltas
            MateriaManager.sharedInstance.salvar()
            }
        }
        
        updateUI()
    }

    func updateUI() {
        if let m = materia {
            lblPercentualFalta.text = "Faltas \(m.quantFaltas) de \(m.faltas) permitidas"
        }
        setNeedsDisplay()
    }
}
