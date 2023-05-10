//
//  ApiManager.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import Foundation
import CoreData
import Moya
import RxSwift
import RxCocoa

protocol Api {
    func fetchUser() -> Single<[UserModel]>
}

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

   private lazy var provider: MoyaProvider = {
        return MoyaProvider(endpointClosure: endpointClosure)
    }()
}

// MARK: - Fetch USERS ,POST, COMMENTS

extension ApiManager: Api {

    func fetchUser() -> Single<[UserModel]> {
        return Single<[UserModel]>.create { single in
            self.provider.request(.users) { (result)  in
                switch result {
                    case .success(let response):
                        guard let jsonData = try? JSONDecoder().decode([UserModel].self, from: response.data) else {
                            return
                        }
                        single(.success(jsonData))
                    case .failure(let error):
                        print(error)
                        single(.failure(error))
                }
            }
            return Disposables.create {}
        }
    }
    
    func fetchUserPost(userId: Int, completion: @escaping([UserPost]?) -> ()) {

        self.provider.request(.showPostByUserId(userId: userId)) { result in
            switch result {
                case .success(let moyaResponse):
                    let data = moyaResponse.data // Data, your JSON response is probably in here!
                    let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                    let json = try? JSONDecoder().decode([UserPost].self, from: data)
                    print("Success to fetchUserPost -> \(String(describing: json))")
                    
                    completion(json)
                case .failure(let error): print("Failed to decode user data \(error.localizedDescription)")
            }
        }
    }
    
    func fetchUserPostComment(postID: Int, completion: @escaping([UserPostComment]?) -> ()) {

        self.provider.request(.showPostCommentsByUserPostId(postId: postID)) { result in
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
