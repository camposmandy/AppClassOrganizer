//
//  MateriaManager.swift
//  MC03
//
//  Created by Leonardo Rodrigues de Morais Brunassi on 19/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//
//

import Foundation
import CoreData

class MateriaManager {
    static let sharedInstance = MateriaManager()
    static let entidadeNome = "Materia"
    
    let coreData = CoreDataPersistencia.sharedInstance
    
    private init(){}
    
    func novaMateria() -> MC03.Materia {
        return NSEntityDescription.insertNewObjectForEntityForName(MateriaManager.entidadeNome, inManagedObjectContext: coreData.managedObjectContext!) as! MC03.Materia
    }
    
    func Materia() -> Array<MC03.Materia>? {
        return coreData.fetchData(MateriaManager.entidadeNome, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<MC03.Materia>
    }
    
    func Materia(predicate: NSPredicate) -> Array<MC03.Materia>?{
        return coreData.fetchData(MateriaManager.entidadeNome, predicate: predicate) as? Array <MC03.Materia>
    }
    
    func salvar() {
        coreData.saveContext()
    }
    
    func deletar(materia: MC03.Materia) {
        coreData.managedObjectContext?.deleteObject(materia)
    }
    
    func deletarTudo() {
        let todosObjetos: Array<MC03.Materia> = self.Materia()!
        
        for item : MC03.Materia in todosObjetos as Array<MC03.Materia> {
            self.deletar(item)
        }
    }
}






//import Foundation
//import CoreData
//import UIKit
//
//class MateriaManager {
//    static let sharedInstance: MateriaManager = MateriaManager()
//    
//    static let entidadeNome = "Materia"
//    
//    let coreData: NSManagedObjectContext = {
//        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        var aux = appDelegate.managedObjectContext
//        return aux!
//    }()
//    
//    private init(){}
//    
//    func novaMateria() -> MC03.Materia {
//        return NSEntityDescription.insertNewObjectForEntityForName(MateriaManager.entidadeNome, inManagedObjectContext: coreData) as! MC03.Materia
//    }
//    
//    func buscarMateria() -> Array<MC03.Materia>? {
//        let fetchRequest = NSFetchRequest(entityName: MateriaManager.entidadeNome)
//        
//        var error: NSError?
//        
//        let fetchedResults = coreData.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
//        
//        if let results = fetchRequest as? [Materia] {
//            return results
//        }else{
//            println("Could not fetch. Error: \(error), \(error!.userInfo)")
//        }
//        return Array<Materia>()
//    }
//    
//    func salvar() {
//        var error: NSError?
//        coreData.save(&error)
//    }
//    
//    func deletar(materia: MC03.Materia) {
//        coreData.managedObjectContext?.deleteObject(materia)
//    }
//    
//    func deletarTudo() {
//        let todosObjetos: Array<MC03.Materia> = self.Materia()!
//        
//        for item : MC03.Materia in todosObjetos as Array<MC03.Materia> {
//            self.deletar(item)
//        }
//    }
//}