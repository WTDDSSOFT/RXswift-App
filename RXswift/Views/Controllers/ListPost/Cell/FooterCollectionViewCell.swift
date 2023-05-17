//
//  FooterCollectionViewCell.swift
//  RXswift
//
//  Created by william torres dias dos santos on 01/05/23.
//

import UIKit

class FooterCollectionViewCell: UICollectionViewCell {

   private lazy var userName: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .boldSystemFont(ofSize: 18)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 30).isActive = true
      return label
   }()

   private lazy var website: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .boldSystemFont(ofSize: 14)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 30).isActive = true
      return label
   }()

   private lazy var body: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .systemFont(ofSize: 15)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()

   static let identifier = "FooterCollectionViewCell"

   override init(frame: CGRect) {
      super.init(frame: frame)

      addSubview(userName)
      addSubview(website)
      addSubview(body)

      contentView.layer.cornerRadius = 5.0
      contentView.layer.masksToBounds = true

      layer.cornerRadius = 5.0
      layer.masksToBounds = false

      // How blurred the shadow is
      layer.shadowRadius = 8.0

      // The color of the drop shadow
      layer.shadowColor = UIColor.black.cgColor

      // How transparent the drop shadow is
      layer.shadowOpacity = 0.10

      // How far the shadow is offset from the UICollectionViewCell’s frame
      layer.shadowOffset = CGSize(width: 0, height: 5)

      // Specify a shadowPath to improve shadow drawing performance
      layer.shadowPath = UIBezierPath(
         roundedRect: bounds,
         cornerRadius: 5.0
      ).cgPath

      self.backgroundColor = .blue
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }


   override func layoutSubviews() {

      NSLayoutConstraint.activate([
         userName.topAnchor.constraint(equalTo: topAnchor),
         userName.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),

         website.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5),
         website.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),

         body.topAnchor.constraint(equalTo: website.bottomAnchor, constant:  5),
         body.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
         body.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
         body.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
   }
   
}
