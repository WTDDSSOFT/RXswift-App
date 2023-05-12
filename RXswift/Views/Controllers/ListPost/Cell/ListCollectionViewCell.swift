//
//  ListCollectionViewCell.swift
//  RXswift
//
//  Created by william torres dias dos santos on 27/04/23.
//

import UIKit
import SkeletonView

class ListCollectionViewCell: UICollectionViewCell {

    lazy var titleLb: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        label.clipsToBounds = true
        label.textColor = .darkTextFeild
        label.isSkeletonable = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()

    lazy var bodyLb: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.clipsToBounds = true
        label.textColor = .darkTextFeild
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        label.textAlignment = .justified
        return label
    }()

    static let identifier = "ListCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)

        isSkeletonable = true
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        NSLayoutConstraint.activate([

            titleLb.topAnchor.constraint(equalTo: topAnchor),
            titleLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            bodyLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 5),
            bodyLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bodyLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bodyLb.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)

        ])
    }

    func configCell(userM: UserPostViewModel) {
        self.titleLb.stopSkeletonAnimation()
        self.bodyLb.stopSkeletonAnimation()
        print("userVM \(userM.title)")
        self.titleLb.text = userM.title
        self.bodyLb.text = userM.body
    }

    private func setupCell() {
        addSubview(titleLb)
        addSubview(bodyLb)

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

        self.titleLb.showAnimatedSkeleton(usingColor: UIColor.greenSea)
        self.bodyLb.showAnimatedSkeleton(usingColor: UIColor.greenSea)
        
        self.backgroundColor = .white
    }
}
