//
//  ListPostViewController.swift
//  RXswift
//
//  Created by william torres dias dos santos on 12/05/23.
//

//
//  ListCollectionViewController.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

final class ListPostViewController: UIViewController {

    private let collection = CollectionView()
    private let api = ApiManager()
    private let disposeBag = DisposeBag()

    var findUser: Int!
    var refreshControl: UIRefreshControl!

    convenience init(findUser: Int) {
        self.init()
        self.findUser = findUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = .white
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        collection.collectionView.refreshControl = refreshControl

        setuptBehaviours()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstrants()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupBindings() {

        let input = UserPostViewModel.Input(
            refresh: self.refreshControl.rx.controlEvent(.valueChanged).filter({
                [weak self] _ in self?.refreshControl.isRefreshing ?? false})
            .startWith(())
        )

        let viewModel = UserPostViewModel(userId: self.findUser)
        let output = viewModel.bind(input: input)

        output.userPostList
            .drive(self.collection.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)

        output.isLoading
            .drive(self.refreshControl.rx.isRefreshing)
            .disposed(by: self.disposeBag)
    }

    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<Void, UserPost>> = {
        return .init(configureCell: { dataSource, collectionView, indexPath, item -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ListCollectionViewCell.identifier,
                for: indexPath
            ) as! ListCollectionViewCell
            cell.configCell(userM: item)
            return cell
        })
    }()


    private func setuptBehaviours() {
        self.collection.collectionView.rx
            .modelSelected(UserPost.self).subscribe { item in
            let vc = UserPostCommentsViewController(postId: item.element?.id ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: self.disposeBag)
    }

}



//MARK: - UI
extension ListPostViewController {

    private func setupUI() {
        self.view.backgroundColor = .darkBackground
        self.collection.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collection)
        self.title = "Post"
    }

    private func applyConstrants() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collection.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
