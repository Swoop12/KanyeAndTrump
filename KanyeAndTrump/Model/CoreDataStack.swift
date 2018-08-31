//
//  CoreDataStack.swift
//  KanyeAndTrump
//
//  Created by DevMountain on 8/30/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack{
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "KanyeAndTrump")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                fatalError("Failed to Load from the CoreDataStack \(error), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    static func saveToPersistentStore(){
        do{
            try CoreDataStack.context.save()
        }catch {
            print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
        }
    }
    
    static func delete(quote: Quote) {
        CoreDataStack.context.delete(quote)
        saveToPersistentStore()
    }
}




























