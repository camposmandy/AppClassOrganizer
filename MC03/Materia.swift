//
//  Materia.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class Materia: NSManagedObject {

    @NSManaged var nomeMateria: String
    @NSManaged var nomeProfessor: String
    @NSManaged var cargaHoraria: NSNumber
    @NSManaged var diasAula: NSNumber
    @NSManaged var faltas: NSNumber
    @NSManaged var media: NSNumber
    @NSManaged var possuiNota: NSSet
    @NSManaged var possuiTarefa: NSSet

}
