//
//  ProductFullScreenView.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 27.03.24.
//

import UIKit

class ProductFullScreenView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
        
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: TextSize.extraLarge.getSize())
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.large.getSize(), weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.medium.getSize())
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: TextSize.medium.getSize())
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: TextSize.small.getSize())
        return label
    }()
    
    private let mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.mainColor
        let image = UIImage(systemName: "cart")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = Constants.elementCornerRadius
        return button
    }()
    
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
        priceLabel.text = "\(product.price ?? 0.0) $"
        descriptionLabel.text = product.description
        categoryLabel.text = product.category.rawValue.capitalized
        ratingLabel.text = "Rating: \(product.rating.rate)☆ (\(product.rating.count) reviews)"
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
private extension ProductFullScreenView {
    
    func setupConfiguration() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(mainVStack)
        addSubview(addToCartButton)
        [titleLabel, priceLabel, descriptionLabel, categoryLabel, ratingLabel].forEach {
            mainVStack.addArrangedSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            mainVStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ConstantsProductFullScreen.mainVStackTopAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: ConstantsProductFullScreen.leadingConstraint),
            mainVStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: ConstantsProductFullScreen.leadingConstraint),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: ConstantsProductFullScreen.imageViewHeight),
            
            addToCartButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ConstantsProductFullScreen.buttonPadding),
            addToCartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ConstantsProductFullScreen.buttonPadding),
            addToCartButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -ConstantsProductFullScreen.buttonPadding),
            addToCartButton.heightAnchor.constraint(equalToConstant: ConstantsProductFullScreen.buttonHeight),
            
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ConstantsProductFullScreen.leadingConstraint)
        ])
    }
}

// MARK: - Constants
fileprivate struct ConstantsProductFullScreen {
    static let buttonPadding: CGFloat = 10
    static let buttonHeight: CGFloat = 50
    static let leadingConstraint: CGFloat = 20
    static let imageViewHeight: CGFloat = 450
    static let mainVStackTopAnchor: CGFloat = 50
}
