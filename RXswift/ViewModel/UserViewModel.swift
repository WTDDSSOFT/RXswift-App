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

public class UserViewModel: NSObject {
   
   private let model: UserModel

   init(model: UserModel) {
      self.model = model
   }

   public var name: String {
      return model.name ?? ""
   }

   public var email: String {
      return model.email ?? ""
   }

   public var phone: String {
      return model.phone ?? ""
   }

   public var website: String {
      return model.website ?? ""
   }

   public var companyName: String {
      return model.company.name ?? ""
   }

}
