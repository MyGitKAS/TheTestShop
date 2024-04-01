//
//  ProductViewCell.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import UIKit

final class ProductViewCell: UICollectionViewCell {
    
    static let identifier = "ProductViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .medium)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .regular)
        return label
    }()
    
    private  let cartButton = UIButton.cartButton(target: self, action: #selector(cartButtonTapped))
    
    var onCartButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithProduct(_ product: Product) {
        titleLabel.text = product.title
        priceLabel.text = String(product.price ?? 0) + "$"
        guard let imageUrl = product.image else {
            imageView.image = PlaceholderImage.defaultImage
            return
        }
        ImageLoaderService.shared.loadImage(from: imageUrl) { [weak self] image in
                guard let self = self else { return }
                self.imageView.image = image
        }
    }
}

// MARK: - Private methods
private extension ProductViewCell {
    @objc func cartButtonTapped() {
        onCartButtonTapped?()
    }
    
    func setupConfiguration() {
        contentView.addSubview(imageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cartButton)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = Constants.elementCornerRadius
        contentView.clipsToBounds = true
    }
}

// MARK: - Setup Constraints
extension ProductViewCell {
    private func setupConstraints() {
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
