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

final class ListCollectionViewController: UICollectionViewController {

    public var findUser: Int? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let findUser = self.findUser else { return  }
                self.api.fetchUserPost(userId: findUser).subscribe { result in
                    switch result {
                        case .success(let userPost):
                            self.userPostVM = userPost
                            self.collectionView.reloadData()
                        case .failure(let error):
                            print("Ops somtim goes wrong \(error.localizedDescription)")
                    }
                }.disposed(by: self.disposeBag)
            }
        }
    }

    private var userPostVM: [UserPost]?
    private let api = ApiManager()
    private let disposeBag = DisposeBag()

    private func collectionViewSetup () {

        collectionView!.register(ListCollectionViewCell.self,
                                 forCellWithReuseIdentifier: ListCollectionViewCell.identifier)

        collectionView!.register(HeaderCollectionViewCell.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier:  HeaderCollectionViewCell.identifier)

        collectionView!.register(FooterCollectionViewCell.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: FooterCollectionViewCell.identifier)

        collectionView.backgroundColor = .darkBackground
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

//MARK: - UICollectionViewDataSource

extension ListCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int
    ) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userPostVM?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCollectionViewCell.identifier,
            for: indexPath
        ) as! ListCollectionViewCell

        guard let userM = userPostVM?[indexPath.row] else { return UICollectionViewCell() }

        cell.configCell(userM: UserPostViewModel(model: userM))

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {

        collectionView.cellForItem(at: indexPath)
        guard let postId = userPostVM?[indexPath.row] else { return }
        api.fetchUserPostComment(postID: postId.id ?? 0).subscribe{ result in
            switch result {
            case .success(let userPostComments):
                let vc = UserPostCommentsViewController()
                print("success to get data \(userPostComments)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Failure to decode  userPostComments data \(error.localizedDescription)")
            }
        }.disposed(by: self.disposeBag)
    }

}

//MARK: - UICollectionViewDelegateFlowLayout

extension ListCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        return CGSize(width: collectionView.bounds.size.width - 46, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {

        return 20
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int
    ) -> UIEdgeInsets {

        return UIEdgeInsets.init(top: 40, left: 0, bottom: 40, right: 0)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath
    ) -> UICollectionReusableView {

        switch kind {

            case UICollectionView.elementKindSectionHeader:
                let headerCell = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HeaderCollectionViewCell.identifier,
                    for: indexPath) as! HeaderCollectionViewCell

                return headerCell

            case UICollectionView.elementKindSectionFooter:
                let footerCell = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: FooterCollectionViewCell.identifier,
                    for: indexPath) as! FooterCollectionViewCell

                return footerCell

            default:
                fatalError("Failed to load header ou footer collectionCell")
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {

        return CGSize(width: 0, height: 90.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int
    ) -> CGSize {

        return CGSize(width: 0, height: 80.0)
    }
}
