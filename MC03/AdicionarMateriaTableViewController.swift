
// Organizado
// Rever código

//  AdicionarMateriaTableViewController.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import CoreData

class AdicionarMateriaTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nomeMateria: UITextField!
    @IBOutlet weak var professor: UITextField!
    @IBOutlet weak var percentualFalta: UITextField!
    @IBOutlet weak var cargaHoraria: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var media: UITextField!
    @IBOutlet weak var switchFaltas: UISwitch!
    @IBOutlet weak var labelDiaDaSemana: UILabel!
    
    // MARK: - Variáveis
    
    var materia: Materia!
    var nota: Nota?
    var diasSemana: Array<DiasSemana>?
    var alertMensagem = ""
    var teste = ""
    var semana = [false, false, false, false, false, false, false]
    let nameSemana = [" dom"," seg"," ter"," qua"," qui", " sex", " sáb"]
    var diaAula: String = ""
    var index: NSIndexPath?

    // MARK: - View
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeMateria.delegate = self
        professor.delegate = self
        percentualFalta.delegate = self
        cargaHoraria.delegate = self
        media.delegate = self
    }
    
    // View Will Appear
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        diaAula = ""
        if semana == [true, false, false, false, false, false, true] {
            diaAula = "Fins de Semana"
        } else if semana == [false, true, true, true, true, true, false] {
            diaAula = "Dias de Semana"
        } else if semana == [true, true, true, true, true, true, true] {
            diaAula = "Todos os Dias"
        } else if semana != [false, false, false, false, false, false, false] {
            var auxSemana = ""
            for i in 0...semana.count-1 {
                if semana[i] == true {
                    auxSemana += nameSemana[i] + ","
                }
            }
            if Array(auxSemana.characters)[auxSemana.characters.count-1] == "," {
                diaAula = auxSemana.substringToIndex(auxSemana.endIndex.predecessor())
            }
        }
        labelDiaDaSemana.text = diaAula
        nomeMateria.resignFirstResponder()
        self.navigationItem.title = "Adicionar Matéria"
    }
    
    override func viewDidAppear(animated: Bool) {
        if index != nil {
            tableView.deselectRowAtIndexPath(index!, animated: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = "Voltar"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath
    }
    
    // Prepare For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cellSemana" {
            if let proxVC = segue.destinationViewController as? DiasDaSemanaViewController {
                proxVC.senderAdcViewController = self
            }
        }
    }
    
    // MARK: - TableView
    
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
    
    // MARK: - Actions
    
    @IBAction func switchFaltas(sender: AnyObject) {
        tableView.reloadData()
    }
    
    @IBAction func buttonCancelar(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func buttonSalvar(sender: AnyObject) {
        salvarMateria()
    }
    
    // MARK: - Teclado e TextField
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.nomeMateria {
            self.professor.becomeFirstResponder()
        } else if textField == self.professor {
            self.media.becomeFirstResponder()
        } else if textField == self.media {
            textField.resignFirstResponder()
        } else if textField == self.percentualFalta {
            self.cargaHoraria.becomeFirstResponder()
        } else if textField == self.cargaHoraria {
            textField.resignFirstResponder()
            self.performSegueWithIdentifier("cellSemana", sender: nil)
        }
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if textField == percentualFalta || textField == cargaHoraria {
            if string.characters.count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        if textField == media {
            if string.characters.count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.,").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
                
                // Verificação para não entrar mais que um ponto (.)
                var countDot = 0
                if string == "." || string == ","{
                    countDot++
                    for c in textField.text!.characters {
                        if c == "." || c == "," {
                            countDot++
                        }
                    }
                    if countDot > 1 {
                        return false
                    }
                }
            }
        }
        return result
    }
    
    // MARK: - Outras Funções
    
    func verificaCampoVazio () -> Bool {
        var aux: Bool?
        var alert = false
        var alertaM = ""
        let alertaT = "Atenção ⚠️"
        
        if (nomeMateria.text == "") {
            alertaM += "- Preencha o Nome da Matéria\n"
            alert = true
        }
        
        if (media.text == "") {
            alertaM += "- Preencha a nota da Matéria\n"
            alert = true
        }
        
        let auxMedia = (media.text!.stringByReplacingOccurrencesOfString(",", withString: ".") as NSString).doubleValue

        if auxMedia < 0 || auxMedia > 10 {
            alertaM += "- Média de 0 a 10\n"
            alert = true
        }
        
        if switchFaltas.on {
            if (percentualFalta.text == "") {
                alertaM += "- Preencha Percentual de Faltas\n"
                alert = true
            }
            
            let auxPerFalta = (percentualFalta.text! as NSString).doubleValue
            
            if auxPerFalta < 0 || auxPerFalta > 100 {
                alertaM += "- Percentual de 0% a 100%\n"
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
            self.navigationController?.popViewControllerAnimated(true)
            return true
        } else {
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
    
    func salvarMateria () -> Void {
        if verificaCampoVazio() {
            
            materia = MateriaManager.sharedInstance.novaMateria()
            
            materia.nomeMateria = nomeMateria.text!
            
            if professor.text != "" {
                materia.nomeProfessor = professor.text!
            } else {
                materia.nomeProfessor = ""
            }
            
            if switchFaltas.on {
                materia.cargaHoraria = Int(cargaHoraria.text!)!
                materia.faltas = Int(percentualFalta.text!)!
                materia.quantFaltas = 0
                materia.controleFaltas = 1
            } else {
                materia.cargaHoraria = 0
                materia.faltas = 0
                materia.quantFaltas = 0
                materia.controleFaltas = 0
            }
            
            materia.media = (media.text!.stringByReplacingOccurrencesOfString(",", withString: ".") as NSString).doubleValue
            
            diasSemana = DiaSemanaManager.sharedInstance.DiasSemana()
            
            for i in 0..<self.semana.count {
                if semana[i] == true {
                    let dia = diasSemana?[i]
                    materia.adcDiaSemana(dia!)
                }
            }
            MateriaManager.sharedInstance.salvar()
        }
    }
}