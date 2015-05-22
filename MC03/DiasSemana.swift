//
//  DiasSemana.swift
//  MC03
//
//  Created by Amanda Guimaraes Campos on 22/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class DiasSemana: NSManagedObject {

    @NSManaged var domingo: NSNumber
    @NSManaged var quarta: NSNumber
    @NSManaged var quinta: NSNumber
    @NSManaged var sabado: NSNumber
    @NSManaged var segunda: NSNumber
    @NSManaged var sexta: NSNumber
    @NSManaged var terca: NSNumber
    @NSManaged var pertenceMateria: NSSet

}
