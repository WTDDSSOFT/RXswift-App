//
//  UserViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import Foundation
import CoreData

//public class UserViewModel: NSManagedObject {
//
//   var userName: String = ""
//   var phone: String = ""
//   var name: String = ""
//   var email: String = ""
//   var website: String = ""
//   var id: Int16 = 0
//
//   func save() {
//      let manager = CoreDataManager.shard
//      let user = User(context: manager.persistentContainer.viewContext)
//
//      user.id = id
//      user.username = userName
//      user.phone = phone
//      user.email = email
//      user.website = website
//   }
//
//}

struct UserViewModel: Codable {
   var username: String?
   var phone: String?
   var name: String?
   var email: String?
   var website: String?
   var id: Int?

   init(
      username: String? = nil,
      phone: String? = nil,
      name: String? = nil,
      email: String? = nil,
      website: String? = nil,
      id: Int? = nil
   ) {
      self.username = username
      self.phone = phone
      self.name = name
      self.email = email
      self.website = website
      self.id = id
   }
   
}
