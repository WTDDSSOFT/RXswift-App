//
//  UserPostCommentsView.swift
//  RXswift
//
//  Created by william torres dias dos santos on 02/05/23.
//

import UIKit

final class UserPostCommentsView: UIView {

   private let containerView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.clipsToBounds = true
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()

   private lazy var nameLb: UILabel = {
      let nameLb = UILabel()
      nameLb.font = .boldSystemFont(ofSize: 14)
      nameLb.clipsToBounds = true
      nameLb.textColor = .darkTextFeild
      nameLb.backgroundColor = .systemBlue
      nameLb.translatesAutoresizingMaskIntoConstraints = false
      nameLb.heightAnchor.constraint(equalToConstant: 30).isActive = true
      return nameLb
   }()

   private lazy var emailLb: UILabel = {
      let emailLb = UILabel()
      emailLb.numberOfLines = 0
      emailLb.font = .systemFont(ofSize: 14)
      emailLb.clipsToBounds = true
      emailLb.textColor = .darkTextFeild
      emailLb.backgroundColor = .systemPink
      emailLb.translatesAutoresizingMaskIntoConstraints = false
      emailLb.heightAnchor.constraint(equalToConstant: 30).isActive = true
      return emailLb
   }()

   private lazy var bodyLb: UILabel = {
      let bodyLb = UILabel()
      bodyLb.numberOfLines = 0
      bodyLb.font = .systemFont(ofSize: 14)
      bodyLb.clipsToBounds = true
      bodyLb.backgroundColor = .systemRed
      bodyLb.textColor = .darkTextFeild
      bodyLb.translatesAutoresizingMaskIntoConstraints = false
      return bodyLb
   }()

   override init(frame: CGRect) {
      super.init(frame: frame)
      self.clipsToBounds = true
      addSubview(containerView)
      containerView.addSubview(nameLb)
      containerView.addSubview(emailLb)
      containerView.addSubview(bodyLb)
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
      NSLayoutConstraint.activate([
         
         containerView.topAnchor.constraint(equalTo: topAnchor),
         containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
         containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
         containerView.heightAnchor.constraint(equalToConstant: 250),

         nameLb.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
         nameLb.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
         nameLb.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

         emailLb.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 10),
         emailLb.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
         emailLb.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

         bodyLb.topAnchor.constraint(equalTo: emailLb.bottomAnchor, constant: 10),
         bodyLb.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
         bodyLb.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
         bodyLb.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
      ])
   }

   public func configViewElements(_ userPostCommentVM: UserPostCommentViewModel) {
      self.nameLb.text = userPostCommentVM.name
      self.emailLb.text = userPostCommentVM.email
      self.bodyLb.text = userPostCommentVM.body
   }
}
