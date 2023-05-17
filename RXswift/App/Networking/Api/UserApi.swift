//
//  UserApi.swift
//  RXswift
//
//  Created by william torres dias dos santos on 15/05/23.
//

import Moya

enum UserApi {
    case users
    case showPostByUserId(userId: Int)
    case showPostCommentsByUserPostId(postId: Int)
}

extension UserApi: TargetType {

    var path: String {
        switch self {
        case .users:
            return "/users"
        case .showPostByUserId(userId: let userID):
            return "/users/\(userID)/posts"
        case .showPostCommentsByUserPostId(postId: let postID):
            return "/posts/\(postID)/comments"
        }
    }

    var method: Method {
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

}
