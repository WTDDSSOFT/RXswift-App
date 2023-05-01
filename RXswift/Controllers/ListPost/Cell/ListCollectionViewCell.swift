//
//  ListCollectionViewCell.swift
//  RXswift
//
//  Created by william torres dias dos santos on 27/04/23.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

   private lazy var nameLb: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .boldSystemFont(ofSize: 16)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 20).isActive = true
      return label
   }()

   private lazy var emailLb: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .systemFont(ofSize: 14)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 20).isActive = true
      return label
   }()

   private lazy var phoneLb: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .systemFont(ofSize: 14)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 20).isActive = true
      return label
   }()


   private lazy var websiteLb: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .systemFont(ofSize: 14)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 20).isActive = true
      return label
   }()

   private lazy var companyLb: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .systemFont(ofSize: 14)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 20).isActive = true

      return label
   }()

   static let identifier = "ListCollectionViewCell"

   override init(frame: CGRect) {
      super.init(frame: frame)

      addSubview(nameLb)
      addSubview(emailLb)
      addSubview(phoneLb)
      addSubview(websiteLb)
      addSubview(companyLb)

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

      self.backgroundColor = .gray
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }


   override func layoutSubviews() {

      NSLayoutConstraint.activate([
         
         nameLb.topAnchor.constraint(equalTo: topAnchor),
         nameLb.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),

         emailLb.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 10),
         emailLb.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),

         phoneLb.topAnchor.constraint(equalTo: emailLb.bottomAnchor, constant: 10),
         phoneLb.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),

         websiteLb.topAnchor.constraint(equalTo: phoneLb.bottomAnchor, constant: 10),
         websiteLb.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),

         companyLb.topAnchor.constraint(equalTo: websiteLb.bottomAnchor, constant:  5),
         companyLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
         companyLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
         
      ])
   }

   public func configCell(userM: UserViewModel) {
      self.nameLb.text = userM.name
      self.emailLb.text = userM.email
      self.phoneLb.text = userM.phone
      self.websiteLb.text = userM.website
      self.companyLb.text = userM.companyName
   }
}
