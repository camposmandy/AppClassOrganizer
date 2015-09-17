//
//  DiasSemana.swift
//  MC03
//
//  Created by João Marcos on 26/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc(DiasSemana)
class DiasSemana: NSManagedObject {

    @NSManaged var nomeDia: String
    @NSManaged var pertenceMateria: NSSet

    func adcMateria (materia : Materia) {
        let possuiMateria = self.mutableSetValueForKey("possuiMateria")
        possuiMateria.addObject(materia)
    }
    
    func removerMateria (materia : Materia) {
        let removeMateria = self.mutableSetValueForKey("possuiMateria")
        removeMateria.removeObject(materia)
    }
}
