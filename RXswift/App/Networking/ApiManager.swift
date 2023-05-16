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
    func fetchUserv() -> Observable<[UserModel]>
    func fetchUserPost(userId: Int) -> Observable<[UserPost]>
    func fetchUserPostComment(postID: Int) -> Observable<[UserPostComment]>
}

final public class ApiManager {
    
    static let shared = ApiManager()
    
    private var context: NSManagedObjectContext?

    private let endpointClosure = { (target: UserApi) -> Endpoint in
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

    func fetchUserv() -> Observable<[UserModel]> {

        self.provider.rx.request(UserApi.users)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .filterSuccessfulStatusCodes()
            .map([UserModel].self)
            .asObservable()
    }

    func fetchUserPost(userId: Int) -> Observable<[UserPost]> {
        self.provider.rx.request(UserApi.showPostByUserId(userId: userId))
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .filterSuccessfulStatusCodes()
            .map([UserPost].self)
            .asObservable()
    }

    func fetchUserPostComment(postID: Int) -> Observable<[UserPostComment]> {

        self.provider.rx.request(UserApi.showPostCommentsByUserPostId(postId: postID))
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .filterSuccessfulStatusCodes()
            .map([UserPostComment].self)
            .asObservable()
    }

}
