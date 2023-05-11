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
    private let disposeBag = DisposeBag()
    var refreshControl: UIRefreshControl!
    
    convenience init(postId: Int!) {
        self.init()
        self.postId = postId
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 70
        tableView.backgroundColor = .darkBackground
        tableView .translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserPostItemTableViewCell.self,
                           forCellReuseIdentifier: UserPostItemTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        
        
        
        
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = .white
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.tableView.refreshControl = refreshControl
        
        //self.refreshControl.rx.controlEvent(.valueChanged).filter({[weak self] _ in self?.refreshControl.isRefreshing ?? false})
        let input = UserPostCommentsViewModel.Input(
            refresh: self.refreshControl.rx.controlEvent(.valueChanged).filter({[weak self] _ in self?.refreshControl.isRefreshing ?? false}).startWith(())
        )
        
        let viewModel = UserPostCommentsViewModel(postId: postId)
        let output = viewModel.bind(input: input)

        output.postList
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
        output.isLoading
            .drive(self.refreshControl.rx.isRefreshing).disposed(by: self.disposeBag)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        setupUi()

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
            let cell = tableView.dequeueReusableCell(withIdentifier: UserPostItemTableViewCell.identifier) as! UserPostItemTableViewCell
            cell.configure(with: item)
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

extension UserPostCommentsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
