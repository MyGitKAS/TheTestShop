//
//  FullScreenProductViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 25.03.24.
//

import UIKit

final class ProductFullScreenViewController: UIViewController {
    
    private var productScreenView: ProductFullScreenView!
    private let product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        productScreenView = ProductFullScreenView()
        view = productScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
    }
}

// MARK: - Private methods
private extension ProductFullScreenViewController {
    func setupConfiguration() {
        productScreenView.configureWithProduct(product)
        productScreenView.onCartButtonTapped = { [weak self] in
            guard let self = self else { return }
            CartHolder.addProductInCart(self.product)}
    }
}
