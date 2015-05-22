//
//  DiasSemana.swift
//  MC03
//
//  Created by João Marcos on 22/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

@objc(DiasSemana)

class DiasSemana: NSManagedObject {

    @NSManaged var segunda: NSNumber
    @NSManaged var terca: NSNumber
    @NSManaged var quarta: NSNumber
    @NSManaged var quinta: NSNumber
    @NSManaged var sexta: NSNumber
    @NSManaged var sabado: NSNumber
    @NSManaged var domingo: NSNumber
    @NSManaged var pertenceMateria: NSSet

}
