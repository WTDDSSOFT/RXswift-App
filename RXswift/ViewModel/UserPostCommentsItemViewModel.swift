//
//  UserPostCommentsItemViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

final class UserPostCommentsItemViewModel: ViewModel {

    var postComments: UserPostComment!

    struct Input {
        let allPostComments: Observable<Void>
    }

    struct Output {
        let userPostCommentsToShow: Driver<[SectionModel<Void, UserPostComment>]>
    }

    convenience init(postComments: UserPostComment) {
        self.init()
        self.postComments = postComments
    }

    func bind(input: Input) -> Output {
        let postComments: Observable<[SectionModel<Void, UserPostComment>]> = input.allPostComments
            .map {
                [SectionModel(model: (), items: [self.postComments])]
            }
        return Output(userPostCommentsToShow: postComments.asDriver(onErrorJustReturn: []))
    }
}

