//
//  DiasSemana.swift
//  MC03
//
//  Created by João Marcos on 26/05/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import Foundation
import CoreData

class DiasSemana: NSManagedObject {

    @NSManaged var nomeDia: String
    @NSManaged var pertenceMateria: NSSet

}
