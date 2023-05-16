//
//  UserPostViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 29/04/23.
//

import RxSwift
import RxCocoa

public class UserPostViewModel: ViewModel {

    var userId: Int!

    struct Input {
        let refresh:Observable<Void>
    }

    struct Output {
        let userPostList: Driver<[SectionModel<Void, UserPost>]>
        let isLoading: Driver<Bool>
    }

    convenience init(userId: Int) {
        self.init()
        self.userId = userId
    }

    func bind(input: Input) -> Output {
        let isLoadingRelay = BehaviorRelay(value: false)

        let userPostList = input.refresh
            .do(onNext: { _ in isLoadingRelay.accept(true) })
            .flatMapLatest({ _ in
                ApiManager.shared.fetchUserPost(userId: self.userId)
            })
            .do(onNext: { _ in isLoadingRelay.accept(false)}, onError: {_ in isLoadingRelay.accept(false)})
            .map { userPost in
            return [SectionModel(model: (), items: userPost)]
        }

        return Output(userPostList: userPostList.asDriver(onErrorJustReturn: []),
                      isLoading: isLoadingRelay.asDriver(onErrorJustReturn: false))
    }

}
