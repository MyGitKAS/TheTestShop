//
//  FullScreenProductViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 25.03.24.
//

import UIKit

class ProductFullScreenViewController: UIViewController {
    
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
    
    @objc func addToCart() {
        //TODO: -
    }
    
    func setupConfiguration() {
        productScreenView.configureWithProduct(product)
        productScreenView.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
}
