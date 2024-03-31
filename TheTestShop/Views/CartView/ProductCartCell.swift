//
//  ProductCartCell.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 24.03.24.
//

import UIKit

final class ProductCartCell: UICollectionViewCell {
    
    static let identifier = "ProductCartCell"
    
    private var quantity: Int = 1

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleProduct: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .bold)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .medium)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let subtractButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(subtractButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize(), weight: .medium)
        return label
    }()

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        let image = UIImage(systemName: "trash")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let mainHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()

    private let titleVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    private let quantityHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 0
        return stack
    }()
    
    var onQuantityChanged: ((OperationSum) -> Void)?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithProduct(_ product: Product) {
        titleProduct.text = product.title
        priceLabel.text = "\(product.price ?? 0) $"
        quantityLabel.text = "\(quantity)"
        
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
private extension ProductCartCell {
    @objc func addButtonTapped() {
        quantity += 1
        quantityLabel.text = "\(quantity)"
        onQuantityChanged?(.plus)
    }
    
    @objc func subtractButtonTapped() {
        if quantity > 0 {
            quantity -= 1
            quantityLabel.text = "\(quantity)"
            onQuantityChanged?(.minus)
        }
    }
    
    func setupConfiguration() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = Constants.elementCornerRadius
        clipsToBounds = true
        contentView.addSubview(mainHStack)
        mainHStack.addArrangedSubview(imageView)
        titleVStack.addArrangedSubview(titleProduct)
        titleVStack.addArrangedSubview(priceLabel)
        mainHStack.addArrangedSubview(titleVStack)
        quantityHStack.addArrangedSubview(subtractButton)
        quantityHStack.addArrangedSubview(quantityLabel)
        quantityHStack.addArrangedSubview(addButton)
        mainHStack.addArrangedSubview(quantityHStack)
        mainHStack.addArrangedSubview(deleteButton)
    }    
}

// MARK: - Setup Constraints
extension ProductCartCell {
    private func setupConstraints() {
        mainHStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainHStack.topAnchor.constraint(equalTo: topAnchor),
            mainHStack.leftAnchor.constraint(equalTo: leftAnchor),
            mainHStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        deleteButton.widthAnchor.constraint(equalToConstant: ConstantsProductCartCell.deleteButtonWidth).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: ConstantsProductCartCell.imageViewButtonWidth).isActive = true
        quantityHStack.widthAnchor.constraint(equalToConstant: ConstantsProductCartCell.quantityHStackButtonWidth).isActive = true
    }
}

// MARK: - Constants
fileprivate struct ConstantsProductCartCell {
    static let deleteButtonWidth: CGFloat = 40
    static let imageViewButtonWidth: CGFloat = 60
    static let quantityHStackButtonWidth: CGFloat = 70
}

// MARK: - OperationSum
 enum OperationSum {
    case plus
    case minus
}


