//
//  DataSource.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import RxDataSources

struct MainDataSourceData {

    let name: String?
    let body: String?
    let email: String?

    init(
        name: String?,
        body: String?,
        email: String?
    ) {
        self.name = name
        self.body = body
        self.email = email
    }
}

struct MainTableViewSection {

    let items: [MainDataSourceData]

    init(items: [MainDataSourceData]) {
        self.items = items
    }
}

extension MainTableViewSection: SectionModelType {
    typealias Item = MainDataSourceData

    init(original: Self, items: [Self.Item]) {
        self = original
    }
}
