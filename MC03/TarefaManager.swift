//
//  TarefaManager.swift
//  MC03
//
//  Created by Leonardo Rodrigues de Morais Brunassi on 19/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class TarefaManager {
    static let sharedInstance = TarefaManager()
    static let entidadeNome = "Tarefa"
    
    let coreData = CoreDataPersistencia.sharedInstance
    
    private init(){}
    
    func novaTarefa() -> MC03.Tarefa {
        return NSEntityDescription.insertNewObjectForEntityForName(TarefaManager.entidadeNome, inManagedObjectContext: coreData.managedObjectContext!) as! MC03.Tarefa
    }
    
    func Tarefa() -> Array<MC03.Tarefa>? {
        return coreData.fetchData(TarefaManager.entidadeNome, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<MC03.Tarefa>
    }
    
    func Tarefa(predicate: NSPredicate) -> Array<MC03.Tarefa>?{
        return coreData.fetchData(TarefaManager.entidadeNome, predicate: predicate) as? Array <MC03.Tarefa>
    }
    
    func salvar() {
        coreData.saveContext()
    }
    
    func deletar(tarefa: MC03.Tarefa) {
        coreData.managedObjectContext?.deleteObject(tarefa)
    }

}
