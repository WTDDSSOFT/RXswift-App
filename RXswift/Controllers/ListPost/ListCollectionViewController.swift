//
//  ListCollectionViewController.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import UIKit

class ListCollectionViewController: UICollectionViewController {

   private var userModel: [UserViewModel]?

   override func viewDidLoad() {
      super.viewDidLoad()

      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false
      self.collectionView!.register(ListCollectionViewCell.self,
                                    forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
      collectionView.backgroundColor = .darkBackground
      collectionView.dataSource = self
      collectionView.delegate = self
      //      ApiManager.shared.fetchUserPost(userId: (userModel?.first?.id)!)
      // Do any additional setup after loading the view.
   } 

   override func numberOfSections(in collectionView: UICollectionView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 1
   }


   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of items
      return 3
   }

   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier,
                                                    for: indexPath) as! ListCollectionViewCell
      cell.configCell(title: "test", body: "test test test test")
      return cell
   }

}

extension ListCollectionViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: view.frame.width, height: 150)
   }
}
