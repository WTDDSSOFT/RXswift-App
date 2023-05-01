//
//  UserPostViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 29/04/23.
//

import Foundation

public class UserPostViewModel: NSObject {

  private let post: UserPostModel

   init(post: UserPostModel) {
      self.post = post
   }

   public var userId: Int {
      return post.userId ?? 0
   }

   public var id: Int {
      return post.id ?? 0
   }

   public var title: String {
      return post.title ?? ""
   }

   public var  body: String {
      return post.body ?? ""
   }

   

}
