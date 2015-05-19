//
//  Tarefa.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class Tarefa: NSManagedObject {

    @NSManaged var nomeTarefa: String
    @NSManaged var descricaoTarefa: String
    @NSManaged var dataEntrega: NSDate
    @NSManaged var statusTarefa: NSNumber
    @NSManaged var nota: NSNumber
    @NSManaged var pertenceMateria: Materia
}
