//
//  VerMateriaTableTableViewController.swift
//  MC03
//
//  Created by João Marcos on 21/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class VerMateriaTableTableViewController: UITableViewController {

    
    @IBOutlet weak var lblNomeMateria: UILabel!
    @IBOutlet weak var lblNomeProfessor: UILabel!
    @IBOutlet weak var lblCargaHoraria: UILabel!
    @IBOutlet weak var lblDom: UILabel!
    @IBOutlet weak var lblSeg: UILabel!
    @IBOutlet weak var lblTer: UILabel!
    @IBOutlet weak var lblQua: UILabel!
    @IBOutlet weak var lblQui: UILabel!
    @IBOutlet weak var lblSex: UILabel!
    @IBOutlet weak var lblSab: UILabel!
    @IBOutlet weak var lblPercFaltas: UILabel!
    
    var myColor = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)
    
    var semana: Array<DiasSemana>!
    var materiaAux: Materia!
    var i: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preencherLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func preencherLabels(){
        self.navigationItem.title = materiaAux.nomeMateria
        
        lblNomeMateria.text = materiaAux.nomeMateria
        lblNomeProfessor.text = materiaAux.nomeProfessor
        lblCargaHoraria.text = "\(materiaAux.cargaHoraria) Aulas"

        var ix = materiaAux.cargaHoraria.doubleValue * materiaAux.faltas.doubleValue * 0.01
        var ii = Int(ix)
        lblPercFaltas.text = "\(materiaAux.faltas)%  (\(ii) Aulas)"
        
        var dias = materiaAux.possuiSemana.allObjects as NSArray
        for i in 0...dias.count-1 {
            var nomeDia = (dias.objectAtIndex(i) as! DiasSemana).nomeDia
            if nomeDia == "Domingo" {
                lblDom.textColor = myColor
            }
            if nomeDia == "Segunda" {
                lblSeg.textColor = myColor
            }
            if nomeDia == "Terça" {
                lblTer.textColor = myColor
            }
            if nomeDia == "Quarta" {
                lblQua.textColor = myColor
            }
            if nomeDia == "Quinta" {
                lblQui.textColor = myColor
            }
            if nomeDia == "Sexta" {
                lblSex.textColor = myColor
            }
            if nomeDia == "Sábado" {
                lblSab.textColor = myColor
            }
        }
    }
    
    @IBAction func btnApagarMateria(sender: AnyObject) {
        MateriaManager.sharedInstance.deletar(materiaAux)
        MateriaManager.sharedInstance.salvar()
    }
}
