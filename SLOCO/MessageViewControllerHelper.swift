//
//  MessageViewControllerHelper.swift
//  SLOCO
//
//  Created by mac on 6/7/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import CoreData
import Fakery

extension MessageViewController {

    
    func setupData(){
        clearData()
        let faker = Faker(locale: "nb-NO")

        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if let context = delegate?.managedObjectContext {
            
            
            let mark = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as! User
            
            mark.firstname = "Mark"
            mark.lastname = "Zuck"
            mark.username = "zz"
            mark.password = "pass"
            
            let markProfile = NSEntityDescription.insertNewObjectForEntityForName("Profiles", inManagedObjectContext: context) as! Profile
            markProfile.owner = mark
            markProfile.image = "zuckprofile"
            markProfile.course = "Maths"
            
            print(faker.lorem.paragraph(sentencesAmount: 23))
            createMessageWithContent(faker.lorem.paragraph(sentencesAmount: 23), author: mark, minutesAgo: 3, context: context)
            createMessageWithContent("I would like to buy SLOCO ", author: mark, minutesAgo: 2, context: context)
            createMessageWithContent("What is your offer ? ", author: mark, minutesAgo: 1, context: context)

            let steve = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as! User
            steve.firstname = "Steve"
            steve.lastname = "Jobbs"
            steve.username = "Ste"
            steve.password = "pass"
            
            let steveProfile = NSEntityDescription.insertNewObjectForEntityForName("Profiles", inManagedObjectContext: context) as! Profile
            steveProfile.owner = steve
            steveProfile.image = "steve_profile"
            steveProfile.course = "Maths"
        
            createMessageWithContent("Good morning obrien! Hope you are doing well today? I tried calling you last week but couldnt get through ", author: steve, minutesAgo: 10, context: context)
            createMessageWithContent("Want an Apple device for free ? Would you like your deleivey by post or parcel? ", author: steve, minutesAgo: 1,context: context)
            
            
            let ghandi =  NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as! User
            ghandi.firstname = "Ghandi"
            ghandi.lastname = "The Man"
            ghandi.username = "ghan"
            ghandi.password = "pass"
            
            let ghandiProfile = NSEntityDescription.insertNewObjectForEntityForName("Profiles", inManagedObjectContext: context) as! Profile
            ghandiProfile.owner = ghandi
            ghandiProfile.image = "gandhi"
            ghandiProfile.course = "Maths"
            
            createMessageWithContent("OBrien you're fired.. ", author: ghandi, minutesAgo: 18, context: context)
            createMessageWithContent("Good morning obrien .. ", author: ghandi, minutesAgo: 20, context: context)
            
            
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
        
        loadData()
    }
    
    func loadData(){
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if let context = delegate?.managedObjectContext {
            
            if let messageBuddies = fetchMessageBuddies() {
                messages = [Message]()
                //Fetch recent message of every friend
                for buddy in messageBuddies {
                    let fetchRequest = NSFetchRequest(entityName: "Messages")
                    
                    //filter by name
                    fetchRequest.predicate = NSPredicate(format: "author.username = %@", buddy.username!)

                    //sort by most recent message
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key:"created_at", ascending: false)]
                    
                    //set fetch limit
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        let mostRecentMessage = try (context.executeFetchRequest(fetchRequest)) as? [Message]
                        messages?.appendContentsOf(mostRecentMessage!)
                        
                    } catch {
                        fatalError("Failure to execute fetch request: \(error)")
                    }
                }
                
                messages = messages?.sort({$0.created_at!.compare($1.created_at!) == .OrderedDescending})
            }
     
        }
        
    }
    
    func clearData() {
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext {
            
            
            do {
                let entityNames = ["Users", "Profiles", "Messages"]
                
                //Truncate Entities
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest(entityName: entityName)
                    
                    let objects = try(context.executeFetchRequest(fetchRequest)) as? [NSManagedObject]
                    
                    //delete each record in Entity
                    for object in objects! {
                        context.deleteObject(object)
                    }
                }
               
                
                try (context.save())
            } catch let err {
                print(err)
            }
        }
 
    }
    
    private func createMessageWithContent(content: String, author: User, minutesAgo: Double, context: NSManagedObjectContext) {
        let messageMark = NSEntityDescription.insertNewObjectForEntityForName("Messages", inManagedObjectContext: context) as! Message
        messageMark.author = author
        messageMark.content = content
        messageMark.created_at = NSDate().dateByAddingTimeInterval(-minutesAgo * 60)

    }
    
    private func fetchMessageBuddies() -> [User]? {
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "Users")
            
            do {
                return try context.executeFetchRequest(fetchRequest) as? [User]
            } catch let err {
                print(err)
            }
            
        }
        
        return nil
    }
    
}
