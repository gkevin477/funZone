//
//  Login+CoreDataProperties.swift
//  funZone
//
//  Created by admin on 6/5/22.
//
//

import Foundation
import CoreData


extension Login {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Login> {
        return NSFetchRequest<Login>(entityName: "Login")
    }

    @NSManaged public var username: String?

}

extension Login : Identifiable {

}
