//
//  JsonCoreData+Extension.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}
