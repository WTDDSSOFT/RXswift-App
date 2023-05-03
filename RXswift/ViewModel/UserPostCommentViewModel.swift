//
//  UserPostCommentViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 02/05/23.
//

import RxSwift

public class UserPostCommentViewModel: NSObject {


  private let model: [UserPostComment]

   init(model: [UserPostComment]) {
      self.model = model
   }

   public var postId: Int {
      return model.first?.postId ?? 0
   }

   public var id: Int {
      return model.first?.id ?? 0
   }

   public var name: String {
      return model.first?.name ?? ""
   }

   public var body: String {
      return model.first?.body ?? ""
   }

   public var email: String {
      return model.first?.email ?? ""
   }

   var items = Observable<[String]>.of(
          ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
      )
}
