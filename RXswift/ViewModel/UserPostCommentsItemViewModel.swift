//
//  UserPostCommentsItemViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import Foundation

struct UserPostCommentsItemViewModel {
   var title: String

   init(itemModel: TableViewItem) {
      self.title = itemModel.title
   }
}

