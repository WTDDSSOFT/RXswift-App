//
//  UserPostItemTableViewCell.swift
//  RXswift
//
//  Created by william torres dias dos santos on 03/05/23.
//

import UIKit

class UserPostItemTableViewCell: UITableViewCell {
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
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

}

// MARK: - Configuration
extension UserPostItemTableViewCell {
    func configure(with model: UserPostComment) {
        self.titleLabel.text = model.body
    }
}

// MARK: - UI Setup
extension UserPostItemTableViewCell {
    private func setupUI() {
        self.contentView.addSubview(titleLabel)

        titleLabel.centerXAnchor
            .constraint(equalTo: self.contentView.centerXAnchor)
            .isActive = true

        titleLabel.centerYAnchor
            .constraint(equalTo: self.contentView.centerYAnchor)
            .isActive = true
    }
}
