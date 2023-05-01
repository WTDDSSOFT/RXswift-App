//
//  User.swift
//  RXswift
//
//  Created by william torres dias dos santos on 29/04/23.
//

import Foundation

struct UserModel: Codable {

   var username: String?
   var phone: String?
   var name: String?
   var email: String?
   var website: String?
   var id: Int?

   var address: Address
   var company: Company
}

struct Address: Codable {

   var street: String?
   var suite: String?
   var city: String?
   var zipcode: String?

   var geo: Geo

   struct Geo: Codable {
      var lat: String?
      var lng: String?
   }
}

struct Company: Codable {
   var name: String?
   var catchPhrase: String?
   var bs: String?
}
