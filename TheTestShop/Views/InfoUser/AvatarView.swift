//
//  AvatarView.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 23.03.24.
//

import UIKit

final class AvatarView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: TextSize.large.getSize())
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(name: String) {
        imageView.image = PlaceholderImage.defaultAvatarImage
        nameLabel.text = name.uppercased()
    }
}

// MARK: - Private methods
extension AvatarView {
    func setupConfiguration() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        addSubview(stackView)
    }
}

// MARK: - Setup Constraints
extension AvatarView {
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: ConstantsAvatarView.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: ConstantsAvatarView.imageSize)
        ])
    }
}

// MARK: - Constants
fileprivate struct ConstantsAvatarView {
    static let imageSize: CGFloat = 100
}
