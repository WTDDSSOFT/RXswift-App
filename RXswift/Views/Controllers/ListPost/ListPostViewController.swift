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

class ListPostViewController: UIViewController {

    private var userPostVM: [UserPost]?
    private let api = ApiManager()
    private let disposeBag = DisposeBag()

    var findUser: Int!
    var refreshControl: UIRefreshControl!

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListCollectionViewCell.self,
                                forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        return collectionView
    }()

    convenience init(findUser: Int) {
        self.init()
        self.findUser = findUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = .white
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.collectionView.refreshControl = refreshControl

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
            .drive(self.collectionView.rx.items(dataSource: dataSource))
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
}

//MARK: - UICollectionViewDelegate
extension ListPostViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        collectionView.cellForItem(at: indexPath)
        guard let postId = userPostVM?[indexPath.row] else { return }

        let vc = UserPostCommentsViewController(postId: postId.id ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ListPostViewController:  UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        guard let count = userPostVM?.count else {
            return 0
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.size.width - 46, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 20
    }
}

//MARK: - UI
extension ListPostViewController {

    private func setupUI() {
        self.view.backgroundColor = .darkBackground
        self.view.addSubview(collectionView)
    }

    private func applyConstrants() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
