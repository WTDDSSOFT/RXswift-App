//
//  ListCollectionViewCell.swift
//  RXswift
//
//  Created by william torres dias dos santos on 27/04/23.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

   private lazy var title: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = .boldSystemFont(ofSize: 18)
      label.clipsToBounds = true
      label.textColor = .darkTextFeild
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 50).isActive = true
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

   static let identifier = "ListCollectionViewCell"

   override init(frame: CGRect) {
      super.init(frame: frame)
      addSubview(title)
      addSubview(body)
      self.backgroundColor = .white
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }


   override func layoutSubviews() {
      addConstraints([
         title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
         title.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),

         body.topAnchor.constraint(equalTo: title.bottomAnchor, constant:  5),
         body.leadingAnchor.constraint(equalTo: leadingAnchor),
         body.trailingAnchor.constraint(equalTo: trailingAnchor),
         body.bottomAnchor.constraint(equalTo: bottomAnchor)

      ])
   }

   public func configCell(title: String, body: String) {
      self.title.text = title
      self.body.text = body
   }
}
