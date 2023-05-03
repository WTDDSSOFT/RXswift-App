//
//  AuthViewController.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AuthViewController: UIViewController {

   private let authView = AuthView()
   private let disposeBag = DisposeBag()

   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .darkBackground
      view.addSubview(authView)


      self.authView.userEmail.rx.text.map { currentText -> Bool in
         guard let currentText = currentText else { return false}
         return currentText.count > 3
      }
      .asDriver(onErrorJustReturn: false)
      .drive(self.authView.loginBtn.rx.isEnabled)
      .disposed(by: self.disposeBag)
//
//       Observable.combineLatest(
//         self.authView.userEmail.rx.text.asObservable()
//       ).map { currentEmail  -> Bool in
//            guard let currentEmail = currentEmail else { return false}
//            return currentEmail.count > 6
//        }.asDriver(onErrorJustReturn: false)
//           .drive(self.authView.loginBtn.rx.isEnabled).disposed(by: self.disposeBag)
   }

   override func viewWillAppear(_ animated: Bool) {
      //      authView.loginBtn.isEnabled  = true
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
         y: view.safeAreaInsets.top,
         width: view.bounds.width,
         height: view.bounds.height)
   }

   @objc func didTap(sender: Any) {

      guard let userName = authView.userEmail.text,
            !userName.isEmpty else {
         return
      }
      
      ApiManager().fetchUser { userResponse in
         guard let userResponse = userResponse else { return }
         self.checkUser(userModel: userResponse, userName: userName)
      }
   }
}

extension AuthViewController {

   private func configCollection() -> UICollectionViewFlowLayout {
      let collectionConfiguraiton: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
      collectionConfiguraiton.scrollDirection = .vertical
      return collectionConfiguraiton
   }

   private func checkUser(userModel: [UserModel]?, userName: String) {
      let findUser = userModel?.filter{ $0.username == userName }
      let vc = ListCollectionViewController.init(collectionViewLayout: self.configCollection())
      vc.findUser = findUser?.first?.id
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
         self.navigationController?.pushViewController(vc, animated: true)
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
