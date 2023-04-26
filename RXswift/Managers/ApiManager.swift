//
//  ApiManager.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import Foundation
import Alamofire
import CoreData

class ApiManager {

   static let shared = ApiManager()

   private var alamofire = AF
   
   private var context: NSManagedObjectContext?

   func fetchUser() {
      alamofire.request("https://jsonplaceholder.typicode.com/users").response { result in
         switch result.result {
         case .success(let data):
               guard let data = data else { return }
               print("data\(data.debugDescription)")
               let json = try? JSONDecoder().decode([UserViewModel].self, from: data)
         case .failure(let error):
            print("Failed to decode user data \(error.localizedDescription)")
         }
      }
   }

}
