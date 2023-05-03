//
//  UserPostCommentsViewModel.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import RxSwift

struct UsePostCommentsViewModel {

    var items = BehaviorSubject<[TableViewSection]>(value: [
        TableViewSection(items: [
            TableViewItem(title: "One"),
            TableViewItem(title: "Two"),
            TableViewItem(title: "Three"),
            TableViewItem(title: "Four"),
            TableViewItem(title: "Five"),
            TableViewItem(title: "Six")

        ], header: "First section"),

        TableViewSection(items: [

            TableViewItem(title: "Seven"),
            TableViewItem(title: "Eight"),
            TableViewItem(title: "Nine"),
            TableViewItem(title: "Ten"),
            TableViewItem(title: "Evelen"),
            TableViewItem(title: "Twelve")

        ], header: "Second section")

    ])

    let dataSource = IntermediateDataSource.dataSource()
}
