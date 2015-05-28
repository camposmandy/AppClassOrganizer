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
    
    var materia: Array<Materia>!
    var semana: Array<DiasSemana>!
    var materiaAux: Materia!
    var i: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        materia = MateriaManager.sharedInstance.Materia()
        
        preencherLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func preencherLabels(){
        self.navigationItem.title = materia?[i].nomeMateria
        
        lblNomeMateria.text = materia[i].nomeMateria
        lblNomeProfessor.text = materia[i].nomeProfessor
        lblCargaHoraria.text = "\(materia[i].cargaHoraria) Aulas"
        
        var ix = materia[i].cargaHoraria.doubleValue * materia[i].faltas.doubleValue * 0.01
        var ii = Int(ix)
        lblPercFaltas.text = "\(materia[i].faltas)%  (\(ii) Aulas)"
        
        materiaAux = materia[i] as Materia
        var dias = materiaAux.possuiSemana.allObjects as NSArray
        for i in 0...dias.count-1 {
            var nomeDia = (dias.objectAtIndex(i) as! DiasSemana).nomeDia
            if nomeDia == "Domingo" {
                lblDom.textColor = UIColor.greenColor()
            }
            if nomeDia == "Segunda" {
                lblSeg.textColor = UIColor.greenColor()
            }
            if nomeDia == "Terça" {
                lblTer.textColor = UIColor.greenColor()
            }
            if nomeDia == "Quarta" {
                lblQua.textColor = UIColor.greenColor()
            }
            if nomeDia == "Quinta" {
                lblQui.textColor = UIColor.greenColor()
            }
            if nomeDia == "Sexta" {
                lblSex.textColor = UIColor.greenColor()
            }
            if nomeDia == "Sábado" {
                lblSab.textColor = UIColor.greenColor()
            }
        }
    }
    
    @IBAction func btnApagarMateria(sender: AnyObject) {
        //MateriaManager.deletar(materiaAux)
    }
}
