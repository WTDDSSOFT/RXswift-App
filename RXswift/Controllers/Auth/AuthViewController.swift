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
      ApiManager.shared.fetchUser()
   }

   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      authView.frame = CGRect(
         x: 0,
         y: view.top,
         width: view.frame.width,
         height: view.frame.height)
   }
}

#if DEBUG

import SwiftUI

struct AuthViewController_Preview: PreviewProvider {
   static var previews: some View = Preview(for: AuthViewController())
      .preferredColorScheme(.light)
}

#endif
