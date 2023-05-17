//
//  DataSource.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import RxDataSources

public struct SectionModel<Section, ItemType> {

    public var model: Section
    public var items: [Item]

    public init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
}

extension SectionModel: SectionModelType {

    public typealias Identity = Section
    public typealias Item = ItemType

    public var identity: Section {
        return model
    }

    public init(
        original: SectionModel<Section, ItemType>,
        items: [ItemType]
    ) {
        self.model = original.model
        self.items = items
    }
}

//
//struct MainTableViewSection {
//
//    let items: [MainDataSourceData]
//
//    init(items: [MainDataSourceData]) {
//        self.items = items
//    }
//}
//
