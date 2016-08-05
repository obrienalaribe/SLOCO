//
//  DataSourceHelper.swift
//  SLOCO
//
//  Created by mac on 5/25/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import CoreData

public class DataSourceHelper {
    
    let context: NSManagedObjectContext
    
    let users = [
        (firstname: "OBrien", lastname:"Tommy", username: "breazy", password: "pass")
    ]
    
    let profiles = [
        (course: "Maths", year:4)
    ]
    
    let messages = [
        (content: "Hello World", created_at: NSDate())
    ]
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    public func seedDataStore() {
        clearData()
//        seedUsers()
    }
    
    private func seedUsers(){
        for index in 0...users.count - 1 {
            let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as! User
            let newUserProfile = NSEntityDescription.insertNewObjectForEntityForName("Profiles", inManagedObjectContext: context) as! Profile
            
            newUserProfile.course = profiles[index].course
            newUserProfile.year = profiles[index].year
            newUserProfile.owner = newUser
            
            
            newUser.firstname = users[index].firstname
            newUser.lastname = users[index].lastname
            newUser.username = users[index].username
            newUser.password = users[index].password
            newUser.profile = newUserProfile
            
        }
        
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    public func printUsers(){
        let userFetchRequest = NSFetchRequest(entityName: "Users")
        let primarySortDescriptor = NSSortDescriptor(key: "firstname", ascending: true)
        
        userFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let users = (try! context.executeFetchRequest(userFetchRequest)) as! [User]
        
        for user in users {
            print("name \(user.profile?.owner?.firstname!) course: \(user.profile?.course)")
        }
    }
    
    func clearData() {
    
        do {
            
            let entityNames = ["Users", "Messages"]
            
            for entityName in entityNames {
                let fetchRequest = NSFetchRequest(entityName: entityName)
                
                let objects = try(context.executeFetchRequest(fetchRequest)) as? [NSManagedObject]
                
                for object in objects! {
                    context.deleteObject(object)
                }
            }
            
            try(context.save())
            
        } catch let err {
            print(err)
        }
        
    }

}