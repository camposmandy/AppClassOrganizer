//
//  DiaSemanaManager.swift
//  MC03
//
//  Created by Amanda Guimaraes Campos on 22/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class DiaSemanaManager {
    
    static let sharedInstance = DiaSemanaManager()
    static let entidadeNome = "DiasSemana"
    
    let coreData = CoreDataPersistencia.sharedInstance
    
    private init(){}
    
    func novoDiaSemana() -> MC03.DiasSemana {
        return NSEntityDescription.insertNewObjectForEntityForName(DiaSemanaManager.entidadeNome, inManagedObjectContext: coreData.managedObjectContext!) as! MC03.DiasSemana
    }
    
    func DiasSemana() -> Array<MC03.DiasSemana>? {
        return coreData.fetchData(DiaSemanaManager.entidadeNome, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<MC03.DiasSemana>
    }
    
    func DiasSemana(predicate: NSPredicate) -> Array<MC03.DiasSemana>?{
        return coreData.fetchData(DiaSemanaManager.entidadeNome, predicate: predicate) as? Array <MC03.DiasSemana>
    }
    
    func salvar() {
        coreData.saveContext()
    }
    
    func deletar(semana: MC03.DiasSemana) {
        coreData.managedObjectContext?.deleteObject(semana)
    }
}
