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


   func fetchUser(completion: @escaping([UserModel]?) -> ())  {
      alamofire.request("https://jsonplaceholder.typicode.com/users").response { result in
         switch result.result {
         case .success(let data):
               guard let data = data else { return }
               let json = try? JSONDecoder().decode([UserModel].self, from: data)
               print(json?.count)
               completion(json)
         case .failure(let error): print("Failed to decode user data \(error.localizedDescription)")
         }
      }
   }

   func fetchUserPost(userId: Int,
                      completion: @escaping([UserPostModel]?) -> ()
   ) {
      alamofire.request("https://jsonplaceholder.typicode.com/users/\(userId)/posts").response { result in
         print(result.response)
         switch result.result {
            case .success(let data):
               guard let data = data else { return }
               let json = try? JSONDecoder().decode([UserPostModel].self, from: data)
               print("user posts \(json)")
               completion(json)
            case .failure(let error): print("Failed to decode user data \(error.localizedDescription)")
         }
      }
   }

   func fetchUserPostComment(postd: Int,
                             completion: @escaping([UserPostComment]?) -> ()) {
      alamofire.request("https://jsonplaceholder.typicode.com/posts/\(postd)/comments").response { result in
         print(result.response)
         switch result.result {
            case .success(let data):
               guard let data = data else { return }
               let json = try? JSONDecoder().decode([UserPostComment].self, from: data)
               print("user posts \(json)")
               completion(json)
            case .failure(let error): print("Failed to decode user data \(error.localizedDescription)")
         }
      }

   }
}
