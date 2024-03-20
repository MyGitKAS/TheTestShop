//
//  ProductViewCell.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
    
    static let identifier = "ProductViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .medium)
        return label
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.layer.borderWidth = 1
        return button
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupConstraints()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        imageView.image = UIImage(named: "test")
        titleLabel.text = "Сourgette caviar"
        priceLabel.text = "333 $"
    }
}

// MARK: - Private methods
private extension ProductViewCell {
    
    func setupConfiguration() {
        contentView.addSubview(imageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cartButton)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ConstantsProductViewCell.smallPadding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsProductViewCell.smallPadding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstantsProductViewCell.smallPadding),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ConstantsProductViewCell.smallPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsProductViewCell.smallPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstantsProductViewCell.smallPadding),
            
            priceLabel.bottomAnchor.constraint(equalTo: cartButton.topAnchor, constant: -ConstantsProductViewCell.smallPadding),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsProductViewCell.smallPadding),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstantsProductViewCell.smallPadding),
            
            cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ConstantsProductViewCell.smallPadding),
            cartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ConstantsProductViewCell.smallPadding),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ConstantsProductViewCell.smallPadding),
            cartButton.heightAnchor.constraint(equalToConstant: ConstantsProductViewCell.buttonHeight)
        ])
    }
}

// MARK: - Constants
fileprivate struct ConstantsProductViewCell {
    static let smallPadding: CGFloat = 5
    static let buttonHeight: CGFloat = 40
}
