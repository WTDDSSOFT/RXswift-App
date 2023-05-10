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

class UserPostCommentsViewController: UIViewController, UIScrollViewDelegate {

    private var userPostCommentVM:UserPostComment!
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
//        setupTableView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//MARK: - DATASOURCE RXSWIFT
    lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<Void, UserPostComment>> = {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            let cell = UserPostItemTableViewCell()
            cell.titleLabel.text = item.name
            return cell
        })
    }()

}

extension UserPostCommentsViewController {

//    func setupTableView() {
//        let input = UserPostCommentsItemViewModel.Input(allPostComments: )
//        let viewModel = UserPostCommentsItemViewModel(postComments: self.userPostCommentVM)
//        let outPut = viewModel.bind(input: input )
//    }


    private func setupUi() {
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
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
