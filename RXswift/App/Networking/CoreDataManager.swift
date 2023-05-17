//
//  CoreDataManager.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import Foundation
import CoreData

final class CoreDataManager {

   let persistentContainer: NSPersistentContainer

   static let shard = CoreDataManager()

   private init () {
      persistentContainer = NSPersistentContainer(name: "UserViewModel")
      persistentContainer.loadPersistentStores { description, error in
         if let error = error {
            fatalError("Failed to initiliaze Core Data \(error) ")
         }
      }
   }

   func getAllUsers() -> [User] {
      let fechUserRequest: NSFetchRequest<User> = User.fetchRequest()

      do {
         return try persistentContainer.viewContext.fetch(fechUserRequest)
      } catch {
         return []
      }
   }

}


