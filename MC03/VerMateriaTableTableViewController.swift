
// Organizado
// rever o que esta comentado se pode tirar...

//  VerMateriaTableTableViewController.swift
//  MC03
//
//  Created by João Marcos on 21/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class VerMateriaTableTableViewController: UITableViewController {

    // MARK: - Outlets
    
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
    @IBOutlet weak var lblMedia: UILabel!
    
    // MARK: - Variáveis

    var materia: Materia!
    var appColor = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)

    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carregarDados()
    }
    
    // Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editarMateria" {
            let VC = segue.destinationViewController as! EditarMateriaTableViewController
            VC.materia = materia
        }
    }
    
    // MARK: - Actions
    
    @IBAction func btnApagarMateria(sender: AnyObject) {
        alerta()
    }

    // MARK: - Outras

    func carregarDados(){
        self.navigationItem.title = materia.nomeMateria
        
        lblNomeMateria.text = materia.nomeMateria
        lblNomeProfessor.text = materia.nomeProfessor
        lblMedia.text = "\(materia.media)"
        if materia.controleFaltas == 1 {
            lblCargaHoraria.text = "\(materia.cargaHoraria) Aulas"
            let faltasPermitidas = Int(materia.cargaHoraria.doubleValue * materia.faltas.doubleValue * 0.01)
            lblPercFaltas.text = "\(materia.faltas)%  (\(faltasPermitidas) Aulas)"
        } else {
            lblCargaHoraria.text = "Sem Controle de Faltas"
            lblPercFaltas.text = "Sem Controle de Faltas"
        }

        let dias = materia.possuiSemana.allObjects as NSArray
        for i in 0...dias.count-1 {
            let nomeDia = (dias.objectAtIndex(i) as! DiasSemana).nomeDia
            if nomeDia == "Domingo" {
                lblDom.textColor = appColor
            }
            if nomeDia == "Segunda" {
                lblSeg.textColor = appColor
            }
            if nomeDia == "Terça" {
                lblTer.textColor = appColor
            }
            if nomeDia == "Quarta" {
                lblQua.textColor = appColor
            }
            if nomeDia == "Quinta" {
                lblQui.textColor = appColor
            }
            if nomeDia == "Sexta" {
                lblSex.textColor = appColor
            }
            if nomeDia == "Sábado" {
                lblSab.textColor = appColor
            }
        }
    }
    
    // MARK: - Alerta
    func alerta(){
        let alerta: UIAlertController = UIAlertController(title: "Atenção",
                                                        message: "Certeza que deseja apagar essa matéria?",
                                                 preferredStyle: .Alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            MateriaManager.sharedInstance.deletar(self.materia)
            MateriaManager.sharedInstance.salvar()
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        alerta.addAction(ok)
        
        let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Default) { action -> Void in }
        alerta.addAction(cancelar)
       
        self.presentViewController(alerta, animated: true, completion: nil)
    }
}
