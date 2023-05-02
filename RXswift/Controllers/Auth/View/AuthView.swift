//
//  AuthView.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import UIKit

final class AuthView: UIView {
   
    private lazy var imageView: UIImageView = {
      let imageView = UIImageView(image: UIImage(named: "Login"))
      imageView.clipsToBounds = true
      imageView.contentMode = .scaleToFill
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()

   public lazy var userEmail: UITextField = {
      let textField = UITextField()
      textField.clipsToBounds = true
      textField.layer.backgroundColor = UIColor.darkTextFeild.cgColor
      textField.placeholder = "  Email"
      textField.textAlignment = .justified
      textField.font = .boldSystemFont(ofSize: 14)
      textField.textColor = .lightGray
      textField.layer.cornerRadius = 10
      textField.layer.borderColor = UIColor.lightGray.cgColor
      textField.layer.borderWidth = 1
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.heightAnchor.constraint(equalToConstant: 48).isActive = true

      return textField
   }()
    
    public lazy var userPassword: UITextField = {
       let textField = UITextField()
       textField.clipsToBounds = true
       textField.layer.backgroundColor = UIColor.darkTextFeild.cgColor
       textField.placeholder = "  Email"
       textField.textAlignment = .justified
       textField.font = .boldSystemFont(ofSize: 14)
       textField.textColor = .lightGray
       textField.layer.cornerRadius = 10
       textField.layer.borderColor = UIColor.lightGray.cgColor
       textField.layer.borderWidth = 1
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.heightAnchor.constraint(equalToConstant: 48).isActive = true

       return textField
    }()

   public lazy var loginBtn: UIButton = {
      let button = UIButton()
      button.setTitle("Login", for: .normal)
      button.setTitleColor(.darkBackground, for: .normal)
      button.setTitleColor(.lightGray, for: .disabled)
      button.titleLabel?.font = .boldSystemFont(ofSize: 18)
      button.backgroundColor = UIColor.btnWhite
      button.layer.cornerRadius = 10
      button.clipsToBounds = true
      button.translatesAutoresizingMaskIntoConstraints = false

      button.heightAnchor.constraint(equalToConstant: 48).isActive = true
      button.widthAnchor.constraint(equalToConstant: 250).isActive = true

      return button
   }()

   override init(frame: CGRect) {
      super.init(frame: frame)
      self.clipsToBounds = true
      addSubview(imageView)
      addSubview(userEmail)
      addSubview(userPassword)
      addSubview(loginBtn)

      
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
      addConstraints([
         imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),

         imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
         
         imageView.heightAnchor.constraint(equalToConstant: 340),
         imageView.widthAnchor.constraint(equalToConstant: 340),

         userEmail.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
         userEmail.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
         userEmail.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
         
         userPassword.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: 50),
         userPassword.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
         userPassword.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),

         loginBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
         loginBtn.centerXAnchor.constraint(equalTo: centerXAnchor),

      ])
   }

}
