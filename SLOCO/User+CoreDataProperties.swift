//
//  User+CoreDataProperties.swift
//  SLOCO
//
//  Created by mac on 6/16/16.
//  Copyright © 2016 sloco. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var firstname: String?
    @NSManaged var lastname: String?
    @NSManaged var password: String?
    @NSManaged var username: String?
    @NSManaged var messages: NSSet?
    @NSManaged var profile: Profile?

}
