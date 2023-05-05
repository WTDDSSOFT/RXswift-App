//
//  UserPostCommentsViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import RxSwift

struct UsePostCommentsViewModel {

    var items = BehaviorSubject<[MainTableViewSection]>(value: [
        MainTableViewSection(items: [
            MainDataSourceData(
                name: "test mock",
                body: "jsdfnakjsdngjasngjkansdgjsdjgn;ajsd",
                email: "any_email@gmail.com"
            ),
        ]),

        MainTableViewSection(items: [
            MainDataSourceData(
                name: "test mock 2",
                body: "jsdfnakjsdngjasngjkansdgjsdjgn;ajsd",
                email: "any_email2@gmail.com"
            ),
        ])

    ])
}

