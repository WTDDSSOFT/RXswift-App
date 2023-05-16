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
    var postId: Int!
    var refreshControl: UIRefreshControl!

    private let disposeBag = DisposeBag()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 70
        tableView.backgroundColor = .darkBackground
        tableView .translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserPostItemTableViewCell.self,
                           forCellReuseIdentifier: UserPostItemTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    convenience init(postId: Int) {
        self.init()
        self.postId = postId
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = .white
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.tableView.refreshControl = refreshControl
        
        setupBidings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUi()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupBidings() {

        let input = UserPostCommentsViewModel.Input(
            refresh: self.refreshControl.rx.controlEvent(.valueChanged).filter({
                [weak self] _ in self?.refreshControl.isRefreshing ?? false}
            ).startWith(())
        )

        let viewModel = UserPostCommentsViewModel(postId: postId)
        let output = viewModel.bind(input: input)

        output.postList
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)

        output.isLoading
            .drive(self.refreshControl.rx.isRefreshing).disposed(by: self.disposeBag)
    }

    //MARK: - DATASOURCE RXSWIFT
    lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<Void, UserPostComment>> = {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: UserPostItemTableViewCell.identifier) as! UserPostItemTableViewCell
            cell.configure(with: item)
            return cell
        })
    }()
}

//MARK: - UI & Constrantins

extension UserPostCommentsViewController {

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

extension UserPostCommentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
