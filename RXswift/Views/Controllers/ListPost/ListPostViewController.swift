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
import SkeletonView

class ListPostViewController: UIViewController {

    private var listCollectionViewCell = ListCollectionViewCell()
    private var userPostVM: [UserPost]?
    private let api = ApiManager()
    private let disposeBag = DisposeBag()

    var findUser: Int?

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.isSkeletonable = true
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = true
            collectionView.isScrollEnabled = true
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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .darkBackground
        getUsePost()

        collectionView.prepareSkeleton { done in
            if !done  {
                self.view.showAnimatedSkeleton()
            } else {
                self.view.stopSkeletonAnimation()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getUsePost() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.listCollectionViewCell.titleLb.stopSkeletonAnimation()
            self.collectionView.reloadData()

            guard let findUser = self.findUser else { return  }
            self.api.fetchUserPostv2(userId: findUser).subscribe { userPostResponse in
                self.userPostVM = userPostResponse
                print("user userPostVM -> \(self.userPostVM)")
            }.disposed(by: self.disposeBag)
        }
        
    }
}

// MARK: - SkeletonCollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension ListPostViewController: SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionSkeletonView(_ skeletonView: UICollectionView,
                                cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return ListCollectionViewCell.identifier
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int
    ) -> Int {
        guard let count = userPostVM?.count else {
            return 0
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCollectionViewCell.identifier,
            for: indexPath
        ) as! ListCollectionViewCell

        guard let userVM = userPostVM?[indexPath.row] else { return UICollectionViewCell() }
        cell.configCell(userM: UserPostViewModel(model: userVM))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 46, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)
        guard let postId = userPostVM?[indexPath.row] else { return }

        let vc = UserPostCommentsViewController(postId: postId.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {

        return 20
    }
}
