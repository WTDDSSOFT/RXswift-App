//
//  UserInfomationViewController.swift
//  RXswift
//
//  Created by william torres dias dos santos on 01/05/23.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class UserPostCommentsViewController: UIViewController {

    private var userPostCommentVM = UsePostCommentsViewModel()
    private let disposeBag = DisposeBag()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 70
        tableView.backgroundColor = .darkBackground
        tableView .translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupUi()
        setupTableView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//MARK: - DATASOURCE RXSWIFT
    lazy var dataSource: RxTableViewSectionedReloadDataSource<MainTableViewSection> = {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            let cell = UserPostItemTableViewCell()
            cell.viewModel = UserPostCommentsItemViewModel(itemModel: item)
            return cell
        })
    }()

}

extension UserPostCommentsViewController {

    func setupTableView() {
        userPostCommentVM.items
            .bind(to: tableView
                .rx
                .items(dataSource: dataSource)
            )
            .disposed(by: disposeBag)
    }


    private func setupUi() {

        self.navigationItem.title = "Comments"
        self.view.backgroundColor = .darkBackground
        self.view.addSubview(tableView)
    }

    private func applyConstraints() {

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
