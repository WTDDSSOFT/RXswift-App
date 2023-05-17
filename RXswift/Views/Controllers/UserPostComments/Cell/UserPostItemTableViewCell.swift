//
//  UserPostItemTableViewCell.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import UIKit

final class UserPostItemTableViewCell: UITableViewCell {
    static let identifier = "UserPostItemTableViewCell"

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    private lazy var nameLb: UILabel = {
       let nameLb = UILabel()
       nameLb.font = .boldSystemFont(ofSize: 14)
       nameLb.clipsToBounds = true
       nameLb.textColor = .white
       nameLb.translatesAutoresizingMaskIntoConstraints = false
       nameLb.heightAnchor.constraint(equalToConstant: 20).isActive = true
       return nameLb
    }()

    private lazy var emailLb: UILabel = {
       let emailLb = UILabel()
       emailLb.numberOfLines = 0
       emailLb.font = .italicSystemFont(ofSize: 15)
       emailLb.clipsToBounds = true
       emailLb.textColor = .white
       emailLb.translatesAutoresizingMaskIntoConstraints = false
       emailLb.heightAnchor.constraint(equalToConstant: 10).isActive = true
       return emailLb
    }()

    private lazy var bodyLb: UILabel = {
       let bodyLb = UILabel()
       bodyLb.numberOfLines = 0
       bodyLb.textAlignment = .justified
       bodyLb.font = .systemFont(ofSize: 14)
       bodyLb.adjustsFontSizeToFitWidth = true
       bodyLb.clipsToBounds = true
       bodyLb.textColor = .white
       bodyLb.translatesAutoresizingMaskIntoConstraints = false
       return bodyLb
    }()

}

// MARK: - Configuration
extension UserPostItemTableViewCell {

    func configure(with model: UserPostComment) {
        self.nameLb.text = "Name: \(String(describing: model.name!))"
        self.emailLb.text = "Email: \(String(describing: model.email!))"
        self.bodyLb.text = model.body
    }
}

// MARK: - UI Setup
extension UserPostItemTableViewCell {

    private func setupUI() {
        self.contentView.backgroundColor = .darkTextFeild
        self.contentView.addSubview(nameLb)
        self.contentView.addSubview(emailLb)
        self.contentView.addSubview(bodyLb)

        NSLayoutConstraint.activate([
            nameLb.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            nameLb.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),

            emailLb.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 5),
            emailLb.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),

            bodyLb.topAnchor.constraint(equalTo: emailLb.bottomAnchor, constant: 15),
            bodyLb.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            bodyLb.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            bodyLb.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])

    }
}
