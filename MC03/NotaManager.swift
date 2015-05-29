//
//  NotaManager.swift
//  MC03
//
//  Created by Leonardo Rodrigues de Morais Brunassi on 19/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class NotaManager {
    static let sharedInstance = NotaManager()
    static let entidadeNome = "Nota"
    
    let coreData = CoreDataPersistencia.sharedInstance
    
    private init(){}
    
    func novaNota() -> MC03.Nota {
        return NSEntityDescription.insertNewObjectForEntityForName(NotaManager.entidadeNome, inManagedObjectContext: coreData.managedObjectContext!) as! MC03.Nota
    }
    
    func Nota() -> Array<MC03.Nota>? {
        return coreData.fetchData(NotaManager.entidadeNome, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<MC03.Nota>
    }
    
    func Nota(predicate: NSPredicate) -> Array<MC03.Nota>?{
        return coreData.fetchData(NotaManager.entidadeNome, predicate: predicate) as? Array <MC03.Nota>
    }
    
    func salvar() {
        coreData.saveContext()
    }
    
    func deletar(nota: MC03.Nota) {
        coreData.managedObjectContext?.deleteObject(nota)
    }
    
    func deletarTudo() {
        let todosObjetos: Array<MC03.Nota> = self.Nota()!
        
        for item : MC03.Nota in todosObjetos as Array<MC03.Nota> {
            self.deletar(item)
        }
    }
}
