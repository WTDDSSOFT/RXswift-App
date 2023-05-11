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
    func fetchUserPost(userId: Int) -> Single<[UserPost]>
    func fetchUserPostComment(postID: Int) -> Single<[UserPostComment]>
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
                        print("Failed to decode UserModel data \(error.localizedDescription)")
                        single(.failure(error))
                }
            }
            return Disposables.create {}
        }
    }
    
    func fetchUserv1_5() -> Observable<[UserModel]> {
        return Observable<[UserModel]>.create { observer in
            self.provider.request(.users) { (result)  in
                switch result {
                    case .success(let response):
                        guard let jsonData = try? JSONDecoder().decode([UserModel].self, from: response.data) else {
                            return
                        }
                    return observer.onNext(jsonData)
                    case .failure(let error):
                        print("Failed to decode UserModel data \(error.localizedDescription)")
                    observer.onError(error)
                }
            }
            return Disposables.create {}
        }
    }
    
    func fetchUserv2() -> Observable<[UserModel]> {
        self.provider.rx.request(.users)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .filterSuccessfulStatusCodes()
            .map([UserModel].self)
            .asObservable()
    }
    
    func fetchUserPost(userId: Int) -> Single<[UserPost]> {
        return Single<[UserPost]>.create { single in
            self.provider.request(.showPostByUserId(userId: userId)) { (result) in
                switch result {
                case .success(let response):
                    guard let json = try? JSONDecoder().decode([UserPost].self, from: response.data) else  {
                        return
                    }
                    print("Success to fetchUserPost -> \(String(describing: json))")
                    single(.success(json))
                case .failure(let error):
                    print("Failed to decode UserPost data \(error.localizedDescription)")
                    single(.failure(error))
                }
            }
            return Disposables.create { }
        }
    }
    
    func fetchUserPostComment(postID: Int) -> Single<[UserPostComment]> {
        return Single<[UserPostComment]>.create { single in
            self.provider.request(.showPostCommentsByUserPostId(postId: postID)) { (result) in
                switch result {
                case .success(let response):
                        guard let json = try? JSONDecoder().decode([UserPostComment].self, from: response.data) else {
                            return
                        }
                    print("Success to fetchUserPostComment -> \(String(describing: json))")
                    single(.success(json))
                case .failure(let error):
                    print("Failed to decode user data \(error.localizedDescription)")
                    single(.failure(error))
                }
            }
            return Disposables.create { }
        }
    }
    
    func fetchUserPostCommentv2(postID: Int) -> Observable<[UserPostComment]> {
        self.provider.rx.request(.showPostCommentsByUserPostId(postId: postID))
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .filterSuccessfulStatusCodes()
            .map([UserPostComment].self)
            .asObservable()
    }

}
