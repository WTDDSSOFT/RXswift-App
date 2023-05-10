//
//  UserPostViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 29/04/23.
//

import Foundation

public class UserPostViewModel: NSObject {

  private let model: UserPost

   init(model: UserPost) {
      self.model = model
   }

   public var userId: Int {
      return model.userId ?? 0
   }

   public var id: Int {
      return model.id ?? 0
   }

   public var title: String {
      return model.title ?? ""
   }

   public var body: String {
      return model.body ?? ""
   }


}
