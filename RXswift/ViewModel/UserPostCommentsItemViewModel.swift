//
//  UserPostCommentsItemViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import Foundation

struct UserPostCommentsItemViewModel {
   var name: String?

   init(itemModel: MainDataSourceData) {
      self.name = itemModel.name
   }
}

