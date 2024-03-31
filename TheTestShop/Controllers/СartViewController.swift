//
//  СartViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 23.03.24.
//

import UIKit

class CartViewController: UIViewController {
        
    private var products = CartHolder.products
    private var totalSum: Double = 0.0 {
        didSet {
            updateBottomButton()
        }
    }
    
    private lazy var collectionView: CartCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = CartCollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var bottomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.elementCornerRadius
        button.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
        return button
    }()
    
    private let emptyCartPlaceholder: UILabel = {
           let label = UILabel()
           label.text = "Cart is empty"
           label.textAlignment = .center
           label.isHidden = true
           return label
       }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCartCell.identifier, for: indexPath) as! ProductCartCell
        let product = products[indexPath.row]
        cell.configureWithProduct(product)
        cell.onQuantityChanged = { [weak self] operationSum in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch operationSum {
                    case .minus: self.totalSum -= product.price ?? 0
                    case .plus: self.totalSum += product.price ?? 0
                    }
                }
            }
        return cell
    }
}

// MARK: - Private methods
private extension CartViewController {

    @objc func placeOrder() {
        let formattedSum = String(format: "%.2f", totalSum)
        let alertController = UIAlertController(title: "Your order has been accepted!", message: "Amount: \(formattedSum)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
        CartHolder.removeAllProduct()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.updateView()
        }
    }
    
    func updateView() {
        products = CartHolder.products
        collectionView.reloadData()
        totalSum = products.reduce(0) { $0 + ($1.price ?? 0) }
        updateBottomButton()
        emptyCartPlaceholder.isHidden = !products.isEmpty
    }
    
    func updateBottomButton() {
        let formattedSum = String(format: "%.2f", totalSum)
        bottomButton.setTitle("Order: \(formattedSum)", for: .normal)
    }
    
    func setupConfiguration() {
        view.addSubview(collectionView)
        view.addSubview(emptyCartPlaceholder)
        view.addSubview(bottomButton)
        self.navigationItem.title = "Cart"
        totalSum = products.reduce(0) { $0 + ($1.price ?? 0) }
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        emptyCartPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsCartViewController.buttonPadding),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ConstantsCartViewController.buttonPadding),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ConstantsCartViewController.buttonPadding),
            bottomButton.heightAnchor.constraint(equalToConstant: ConstantsCartViewController.buttonHeight),
            
            emptyCartPlaceholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        emptyCartPlaceholder.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Constants
fileprivate struct ConstantsCartViewController {
    static let buttonPadding: CGFloat = 5
    static let buttonHeight: CGFloat = 50
}
