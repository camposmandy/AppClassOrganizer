//
//  Materia.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc(Materia)
class Materia: NSManagedObject {

    @NSManaged var nomeMateria: String
    @NSManaged var nomeProfessor: String
    @NSManaged var cargaHoraria: NSNumber
    @NSManaged var diasAula: NSNumber
    @NSManaged var faltas: NSNumber
    @NSManaged var media: NSNumber
    @NSManaged var possuiNota: NSSet
    @NSManaged var possuiTarefa: NSSet

    
    func adcNota (nota : Nota) {
        var possuiNota = self.mutableSetValueForKey("possuiNota")
        possuiNota.addObject(nota)
    }
    
    func adcTarefa (tarefa : Tarefa) {
        var possuiTarefa = self.mutableSetValueForKey("possuiTarefa")
        possuiTarefa.addObject(tarefa)
    }
    
    func removerNota (nota : Nota) {
        var removeNota = self.mutableSetValueForKey("possuiNota")
        removeNota.removeObject(nota)
    }
    
    func removerTarefa (tarefa : Tarefa) {
        var removeTarefa = self.mutableSetValueForKey("possuiTarefa")
        removeTarefa.removeObject(tarefa)
    }
}
