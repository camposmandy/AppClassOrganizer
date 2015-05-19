//
//  Nota.swift
//  MC03
//
//  Created by João Marcos on 18/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class Nota: NSManagedObject {

    @NSManaged var tipoNota: String
    @NSManaged var nota: NSNumber
    @NSManaged var pesoNota: NSNumber
    @NSManaged var pertenceMateria: Materia
}
