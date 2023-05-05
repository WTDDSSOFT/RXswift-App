//
//  ApiManager.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import Foundation
import CoreData
import Moya

final public class ApiManager {

    static let shared = ApiManager()

    private var context: NSManagedObjectContext?

    private let endpointClosure = { (target: MyService) -> Endpoint in
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: {.networkResponse(200, target.sampleData)},
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}

// MARK: - Fetch USERS ,POST, COMMENTS

extension ApiManager {

    func fetchUser(completion: @escaping([UserModel]?) -> ())  {
        let provider = MoyaProvider(endpointClosure: endpointClosure)

        provider.request(.users) { result in
            switch result {
            case .success(let moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let json = try? JSONDecoder().decode([UserModel].self, from: data)
                print("Success to fetchUser -> \(String(describing: json))")

                completion(json)
            case .failure(let error): print("Failed to decode user data \(error.localizedDescription)")
            }
        }
    }

    func fetchUserPost(userId: Int, completion: @escaping([UserPostModel]?) -> ()) {
        let provider = MoyaProvider(endpointClosure: endpointClosure)

        provider.request(.showPostByUserId(userId: userId)) { result in
            switch result {
            case .success(let moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let json = try? JSONDecoder().decode([UserPostModel].self, from: data)
                print("Success to fetchUserPost -> \(String(describing: json))")

                completion(json)
            case .failure(let error): print("Failed to decode user data \(error.localizedDescription)")
            }
        }
    }

    func fetchUserPostComment(postID: Int, completion: @escaping([UserPostComment]?) -> ()) {
        let provider = MoyaProvider(endpointClosure: endpointClosure)

        provider.request(.showPostCommentsByUserPostId(postId: postID)) { result in
            switch result {
            case .success(let moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let json = try? JSONDecoder().decode([UserPostComment].self, from: data)
                print("Success to fetchUserPostComment -> \(String(describing: json))")
                completion(json)
            case .failure(let error): print("Failed to decode user data \(error.localizedDescription)")
            }
        }
    }
}
