//
//  Registry+CoreDataProperties.swift
//  RegisterBloodGlucose
//
//  Created by Igor Samoel da Silva on 10/10/21.
//
//

import Foundation
import CoreData


extension Registry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Registry> {
        return NSFetchRequest<Registry>(entityName: "Registry")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var level: Int32

}

extension Registry : Identifiable {

}
