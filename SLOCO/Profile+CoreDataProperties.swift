//
//  Profile+CoreDataProperties.swift
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

extension Profile {

    @NSManaged var course: String?
    @NSManaged var year: NSNumber?
    @NSManaged var image: String?
    @NSManaged var owner: User?

}
