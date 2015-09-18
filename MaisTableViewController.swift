
// Organizado!
// implementar código pra app store e arrumar pra funcionar no ipad

//  MaisTableViewController.swift
//  MC03
//
//  Created by Leonardo Rodrigues de Morais Brunassi on 25/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import MessageUI

class MaisTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    // MARK: - Actions
    
    @IBAction func botaoFeedback(sender: AnyObject) {
        alertaFeedBack()
    }

    @IBAction func buttonDeletarTudo(sender: AnyObject) {
       alertaDeletarTudo()
    }
    
    // MARK: - Alertas
   
    func alertaFeedBack() {
        let alerta: UIAlertController = UIAlertController(title: "Caso queira uma resposta, favor escolher E-Mail",
                                                            message: "",
                                                     preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        alerta.addAction(cancelAction)
        
        let appStore: UIAlertAction = UIAlertAction (title: "App Store", style: .Default) { action -> Void in
        // Implementar código pra App Store
        }
        alerta.addAction(appStore)
        
        let eMail: UIAlertAction = UIAlertAction (title: "E-Mail", style: .Default) { action -> Void in
            let mailComposeViewController = self.configuredMailComposeViewController()
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
        alerta.addAction(eMail)

        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    func alertaDeletarTudo() {
        let alerta: UIAlertController = UIAlertController(title: "Atenção!",
                                                        message: "Você tem certeza que deseja apagar tudo?",
                                                 preferredStyle: .Alert)
        
        let ok: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
            MateriaManager.sharedInstance.deletarTudo()
            NotaManager.sharedInstance.deletarTudo()
            TarefaManager.sharedInstance.deletarTudo()
            
            MateriaManager.sharedInstance.salvar()
            NotaManager.sharedInstance.salvar()
            TarefaManager.sharedInstance.salvar() 
        }

        let cancelar: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Default) { (action) in }
        
        alerta.addAction(cancelar)
        alerta.addAction(ok)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["jmra10@icloud.com"])
        mailComposerVC.setSubject("Feedback Class Organizer")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Impossível mandar um e-mail.",
                                           message: "Seu aparelho não pode enviar email.  Por favor, verifique as configurações e tente novamente.",
                                          delegate: self,
                                 cancelButtonTitle: "OK")
        
        sendMailErrorAlert.show()
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}