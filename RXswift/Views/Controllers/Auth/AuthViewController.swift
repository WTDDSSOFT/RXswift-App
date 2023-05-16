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

    private var authView = AuthView()
    private let disposeBag = DisposeBag()
    private var apiManager = ApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupBehaviors()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .darkBackground
        view.addSubview(authView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        authView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.bounds.width,
            height: view.bounds.height)
    }

    private func setupBindings() {

        self.authView.userEmail.rx.text.map { currentText -> Bool in
            guard let currentText = currentText else { return false}
            return currentText.count > 3
        }
        .asDriver(onErrorJustReturn: false)
        .drive(self.authView.loginBtn.rx.isEnabled)
        .disposed(by: self.disposeBag)
    }

    private func setupBehaviors() {
        self.authView.loginBtn.rx.tap.subscribe(onNext:{ user in
            self.getUser()
        },onError: { error in
            print(error)
        })
        .disposed(by: self.disposeBag)
    }

    private func getUser() {
        guard let userName = authView.userEmail.text,
              !userName.isEmpty else {
            return
        }
        self.apiManager.fetchUserv().subscribe (onNext: { userResponse in
            self.checkUser(userResponse, userName)
        }, onError: { error in
            print(error)
        }).disposed(by: self.disposeBag)
    }
}

extension AuthViewController {

    private func configCollection() -> UICollectionViewFlowLayout {
        let collectionConfiguraiton: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        collectionConfiguraiton.scrollDirection = .vertical
        return collectionConfiguraiton
    }

    private func checkUser(_ useResponse: [UserModel], _ userName: String)  {

        let findUser = useResponse.filter{ $0.username == userName }

        if !findUser.isEmpty {
            let vc = ListPostViewController(findUser: findUser.first?.id ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showAlert()
        }
    }

    private func showAlert() {
        let alert = UIAlertController(
            title: "User not Found",
            message: "Try again",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}

#if DEBUG

import SwiftUI

struct AuthViewController_Preview: PreviewProvider {
    static var previews: some View = Preview(for: AuthViewController())
        .preferredColorScheme(.light)
}

#endif
