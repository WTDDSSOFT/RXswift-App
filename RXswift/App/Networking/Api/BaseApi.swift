//
//  MoyaApi.swift
//  RXswift
//
//  Created by william torres dias dos santos on 04/05/23.
//

import Foundation
import Moya

extension TargetType {

    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

}
