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
import SkeletonView

class ListCollectionViewController: UIViewController {

    var findUser: Int? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.view.stopSkeletonAnimation()
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

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.isSkeletonable = true
            
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false

            collectionView.dataSource = self
            collectionView.delegate = self

            collectionView.register(ListCollectionViewCell.self,
                                    forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
//            collectionView.register(HeaderCollectionViewCell.self,
//                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                    withReuseIdentifier:  HeaderCollectionViewCell.identifier)
//
//            collectionView.register(FooterCollectionViewCell.self,
//                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
//                                    withReuseIdentifier: FooterCollectionViewCell.identifier)
        }
    }

    convenience init(findUser: Int?) {
        self.init()
        self.findUser = findUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.prepareSkeleton { done in
            self.view.showAnimatedSkeleton()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.showSkeleton(usingColor: .clouds, transition: .crossDissolve(0.26))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - UICollectionViewDataSource

extension ListCollectionViewController: UICollectionViewDataSource {

    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                        numberOfItemsInSection section: Int
    //    ) -> Int {
    //        // #warning Incomplete implementation, return the number of items
    //        return userPostVM?.count ?? 0
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                        cellForItemAt indexPath: IndexPath
    //    ) -> UICollectionViewCell {
    //
    //        let cell = collectionView.dequeueReusableCell(
    //            withReuseIdentifier: ListCollectionViewCell.identifier,
    //            for: indexPath
    //        ) as! ListCollectionViewCell
    //
    //        guard let userVM = userPostVM?[indexPath.row] else { return UICollectionViewCell() }
    //        cell.configCell(userM: UserPostViewModel(model: userVM))
    //
    //
    //        return cell
    //    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        collectionView.cellForItem(at: indexPath)
        guard let postId = userPostVM?[indexPath.row] else { return }
        
        let vc = UserPostCommentsViewController(postId: postId.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

////MARK: - UICollectionViewDelegateFlowLayout

extension ListCollectionViewController: UICollectionViewDelegateFlowLayout {

    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        sizeForItemAt indexPath: IndexPath
    //    ) -> CGSize {
    //
    //        return CGSize(width: collectionView.bounds.size.width - 46, height: 150)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        minimumLineSpacingForSectionAt section: Int
    //    ) -> CGFloat {
    //
    //        return 20
    //    }

    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        insetForSectionAt section: Int
    //    ) -> UIEdgeInsets {
    //
    //        return UIEdgeInsets.init(top: 40, left: 0, bottom: 40, right: 0)
    //    }

    //    func collectionView(_ collectionView: UICollectionView,
    //                        viewForSupplementaryElementOfKind kind: String,
    //                        at indexPath: IndexPath
    //    ) -> UICollectionReusableView {
    //
    //        switch kind {
    //
    //            case UICollectionView.elementKindSectionHeader:
    //                let headerCell = collectionView.dequeueReusableSupplementaryView(
    //                    ofKind: kind,
    //                    withReuseIdentifier: HeaderCollectionViewCell.identifier,
    //                    for: indexPath) as! HeaderCollectionViewCell
    //
    //                return headerCell
    //
    //            case UICollectionView.elementKindSectionFooter:
    //                let footerCell = collectionView.dequeueReusableSupplementaryView(
    //                    ofKind: kind,
    //                    withReuseIdentifier: FooterCollectionViewCell.identifier,
    //                    for: indexPath) as! FooterCollectionViewCell
    //
    //                return footerCell
    //
    //            default:
    //                fatalError("Failed to load header ou footer collectionCell")
    //        }
    //    }

    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        referenceSizeForHeaderInSection section: Int
    //    ) -> CGSize {
    //
    //        return CGSize(width: 0, height: 90.0)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        referenceSizeForFooterInSection section: Int
    //    ) -> CGSize {
    //
    //        return CGSize(width: 0, height: 80.0)
    //    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3 - 10, height: view.frame.width/3 - 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK: - SkeletonCollectionViewDataSource

extension ListCollectionViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ListCollectionViewCell.identifier
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell
        cell?.isSkeletonable = indexPath.row != 0
        return cell
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPostVM?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        guard let userVM = userPostVM?[indexPath.row] else { return UICollectionViewCell() }
        cell.configCell(userM: UserPostViewModel(model: userVM))

        return cell
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
        let cell = cell as? ListCollectionViewCell
        cell?.isSkeletonable = indexPath.row != 0
    }

}
