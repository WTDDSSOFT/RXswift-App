//
//  UserPostCommentsViewModel.swift
//  RXswift
//
//  Created by João Isento on 11/05/2023.
//

import RxSwift
import RxCocoa


class UserPostCommentsViewModel: ViewModel {

    var postId: Int!
    
    struct Input {
        let refresh: Observable<Void>
    }
    
    struct Output {
        let postList: Driver<[SectionModel<Void, UserPostComment>]>
        let isLoading: Driver<Bool>
    }
    
    convenience init(postId: Int) {
        self.init()
        self.postId = postId
    }
    
    func bind(input: Input) -> Output {
        let isLoadingRelay = BehaviorRelay(value: false)
        
        let postsList = input.refresh
            .do(onNext: { _ in isLoadingRelay.accept( true )})
            .flatMapLatest({ _ in
                ApiManager.shared.fetchUserPostComment(postID: self.postId)
            })
            .do(onNext: { _ in isLoadingRelay.accept( false )}, onError: {_ in isLoadingRelay.accept( false )})
            .map { posts in
                return [ SectionModel(model: (), items: posts) ]
            }
        
    
        return Output(postList: postsList.asDriver(onErrorJustReturn: []), isLoading: isLoadingRelay.asDriver(onErrorJustReturn: false))
    }
    
    
    
}
