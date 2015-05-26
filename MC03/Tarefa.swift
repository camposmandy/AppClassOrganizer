//
//  Tarefa.swift
//  MC03
//
//  Created by João Marcos on 22/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc(Tarefa)
class Tarefa: NSManagedObject {

    @NSManaged var dataEntrega: NSDate
    @NSManaged var descricaoTarefa: String
    @NSManaged var nomeTarefa: String
    @NSManaged var nota: NSNumber
    @NSManaged var statusTarefa: NSNumber
    @NSManaged var notificacao: NSNumber
    @NSManaged var pertenceMateria: Materia
}
