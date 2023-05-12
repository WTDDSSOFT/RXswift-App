//
//  TableView+Extension.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import UIKit

protocol ReuseIdentifiable {
    static func reuseIdentifier() -> String
}

extension ReuseIdentifiable {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}

