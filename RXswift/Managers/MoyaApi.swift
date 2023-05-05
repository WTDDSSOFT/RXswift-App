//
//  MoyaApi.swift
//  RXswift
//
//  Created by william torres dias dos santos on 04/05/23.
//

import Foundation
import Moya

// User Moya
enum  MyService {
    case users
    case showPostByUserId(userId: Int)
    case showPostCommentsByUserPostId(postId: Int)
}

extension MyService: TargetType {

    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }

    var path: String {
        switch self {
        case .users:
            return "/users"
        case .showPostByUserId(userId: let userID):
            return "/users/\(userID)/posts"
        case .showPostCommentsByUserPostId(postId: let postID):
            return "posts/\(postID)/comments"
        }
    }

    var method: Moya.Method {
        switch self {
        case .users, .showPostByUserId, .showPostCommentsByUserPostId:
        return  .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .users,
             .showPostByUserId,
             .showPostCommentsByUserPostId:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

}
