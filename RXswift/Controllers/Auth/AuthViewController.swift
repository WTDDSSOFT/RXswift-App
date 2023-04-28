//
//  AuthViewController.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import UIKit

class AuthViewController: UIViewController {

   private let authView = AuthView()

   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .darkBackground
      view.addSubview(authView)

      // Do any additional setup after loading the view.
   }

   override func viewWillAppear(_ animated: Bool) {
      authView.loginBtn.isEnabled  = true
      authView.loginBtn.addTarget(
         self,
         action: #selector(didTap),
         for: .touchUpInside
      )
   }

   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      authView.frame = CGRect(
         x: 0,
         y: view.top,
         width: view.bounds.width,
         height: view.bounds.height)
   }

   private func checkUser(userModel: [UserViewModel]?, userName: String) {

      let findUser = userModel?.filter{ $0.username == userName }
      print("user find \(findUser)")
   }


   private func configCollection() -> UICollectionViewFlowLayout {
      let collectionConfiguraiton: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()

      collectionConfiguraiton.scrollDirection = .vertical
      collectionConfiguraiton.minimumLineSpacing = 0
      collectionConfiguraiton.itemSize = .init(width: view.frame.width, height: view.frame.height)
      return collectionConfiguraiton
   }

   @objc func didTap(sender: Any) {
      guard let userName = authView.userEmail.text,
            !userName.isEmpty else {
         return
      }
      
      ApiManager().fetchUser { result in
         self.checkUser(userModel: result, userName: userName)
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.pushViewController(ListCollectionViewController.init(
               collectionViewLayout: self.configCollection()
            ), animated: true)
         }
      }
   }
}

#if DEBUG

import SwiftUI

struct AuthViewController_Preview: PreviewProvider {
   static var previews: some View = Preview(for: AuthViewController())
      .preferredColorScheme(.light)
}

#endif
