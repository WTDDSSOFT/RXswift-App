//
//  DataSource.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import RxDataSources

struct TableViewItem {
    let title: String

    init(title: String) {
        self.title = title
    }
}

struct TableViewSection {
    let items: [TableViewItem]
    let header: String

    init(items: [TableViewItem], header: String) {
        self.items = items
        self.header = header
    }
}

extension TableViewSection: SectionModelType {
    typealias Item = TableViewItem

    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct IntermediateDataSource {

    typealias DataSource = RxTableViewSectionedReloadDataSource

    static func dataSource() -> DataSource<TableViewSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in

            let cell = UserPostItemTableViewCell()
            cell.viewModel = UserPostCommentsItemViewModel(itemModel: item)
            return cell
        }, titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].header
        })
    }
}

