
// Organizado
// Rever código

//  EditarMateriaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 08/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class EditarMateriaTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nomeMateria: UITextField!
    @IBOutlet weak var professorMateria: UITextField!
    @IBOutlet weak var mediaMateria: UITextField!
    @IBOutlet weak var percFaltasMateria: UITextField!
    @IBOutlet weak var cargaHoraria: UITextField!
    @IBOutlet weak var switchFaltas: UISwitch!
    
    // MARK: - Variáveis
    
    var alertMensagem = ""
    var teste = ""
    var materia: Materia!
    var materiaS: Materia!
    var nota: Nota?
    var diaSemana: Array<DiasSemana>?
    var semana = [false, false, false, false, false, false, false]
    
    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        
        nomeMateria.delegate = self
        professorMateria.delegate = self
        percFaltasMateria.delegate = self
        cargaHoraria.delegate = self
        mediaMateria.delegate = self
        
        preencherTFs()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editaSemana" {
            if let proxVC = segue.destinationViewController as? DiasDaSemanaViewController {
                proxVC.senderEditViewController = self
            }
        }
    }
    
    // MARK: - TableView
    // Número de Células
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 2: if switchFaltas.on {
            return 3
        } else {
            return 1
            }
        default: return 1
        }
    }
    
    // MARK:  - Actions
    
    @IBAction func switchFaltas(sender: AnyObject) {
        tableView.reloadData()
    }
    
    @IBAction func buttonCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func buttonSalvar(sender: AnyObject) {
        if verificaCampoVazio() {
            materia.nomeMateria = nomeMateria.text
            materia.nomeProfessor = professorMateria.text
            if switchFaltas.on {
                materia.cargaHoraria = cargaHoraria.text.toInt()!
                materia.faltas = percFaltasMateria.text.toInt()!
            } else {
                materia.cargaHoraria = 0
                materia.faltas = 0
            }
            materia.quantFaltas = 0
            materia.media = (mediaMateria.text as NSString).doubleValue
            
            diaSemana = DiaSemanaManager.sharedInstance.DiasSemana()
            
            for i in 0..<self.semana.count {
                if semana[i] == true {
                    var dia = diaSemana?[i]
                    materia.adcDiaSemana(dia!)
                }
            }
            MateriaManager.sharedInstance.salvar()
        }
    }
    
    // MARK: - Outras
    
    func preencherTFs(){
        self.navigationItem.title = materia.nomeMateria
        nomeMateria.text = materia.nomeMateria
        professorMateria.text = materia.nomeProfessor
        mediaMateria.text = "\(materia.media)"
        
        if materia.controleFaltas == 1 {
            switchFaltas.setOn(true, animated: true)
            cargaHoraria.text = "\(materia.cargaHoraria)"
            percFaltasMateria.text = "\(materia.faltas)"
        } else {
            switchFaltas.setOn(false, animated: true)
            cargaHoraria.text = ""
            percFaltasMateria.text = ""
        }
        tableView.reloadData()
    }
    
    func verificaCampoVazio () -> Bool {
        var aux: Bool?
        var alert = false
        var alertaM = ""
        var alertaT = "Atenção ⚠️"
        
        if (nomeMateria.text == "") {
            alertaM += "- Preencha o Nome da Matéria\n"
            alert = true
        }
        
        if (professorMateria.text == "") {
            alertaM += "- Preencha o Nome do Professor\n"
            alert = true
        }
        
        if (mediaMateria.text == "") {
            alertaM += "- Preencha a Média da Matéria\n"
            alert = true
        }
        
        var auxMedia = (mediaMateria.text as NSString).doubleValue
        
        if auxMedia < 0 || auxMedia > 10 {
            alertaM += "- Média de 0 a 10\n"
            alert = true
        }
        
        if switchFaltas.on {
            if (percFaltasMateria.text == "") {
                alertaM += "- Preencha Percentual de Faltas\n"
                alert = true
            }
            
            var auxPerFalta = (percFaltasMateria.text as NSString).doubleValue
            
            if auxPerFalta < 0 || auxPerFalta > 100 {
                alertaM += "- Peso de 0% a 100%\n"
                alert = true
            }
            
            if(cargaHoraria.text == "") {
                alertaM += "- Preencha a Carga Horaria\n"
                alert = true
            }
        }
        
        if semana == [false, false, false, false, false, false, false] {
            alertaM += "- Escolha um dia da Semana"
            alert = true
        }
        
        if alert == false {
            alertaM = "Matéria Adicionada ✔️"
            alertaT = "Pronto 😃"
            aux = true
        }else{
            aux = false
        }
        
        let alerta: UIAlertController = UIAlertController(title: alertaT, message: alertaM, preferredStyle: .Alert)
        
        let ok:  UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            if (aux == true) {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
        return aux!
    }
    
    // MARK: - Teclado e TextField
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if textField == percFaltasMateria || textField == cargaHoraria || textField == mediaMateria{
            if count(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        return result
    }
}
