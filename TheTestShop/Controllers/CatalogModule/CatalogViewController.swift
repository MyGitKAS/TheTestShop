//
//  CatalogViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    private var products: Products?
    
    private lazy var collectionView: ProductCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = ProductCollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
        getProducts()
    }
    
    func updateData(forCategory: String) {
        ShopApiManager.shared.performRequest(for: .getProductsInCategory(category: forCategory)) { [weak self] (result: Result<Products?, Error>) in
            guard let self = self else { return }
            self.handleProductsResult(result)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewCell.identifier, for: indexPath) as! ProductViewCell
        guard let products = products else { return cell }
        cell.configureWithProduct(products[indexPath.row])
        cell.onCartButtonTapped = { CartHolder.addProductInCart(products[indexPath.row]) }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let products = products else { return }
        let vc = ProductFullScreenViewController(product: products[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Private methods
private extension CatalogViewController {
    func setupConfiguration() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }

    func getProducts() {
        ShopApiManager.shared.performRequest(for: .getAllProducts) { [weak self] (result: Result<Products?, Error>) in
            guard let self = self else { return }
            self.handleProductsResult(result)
        }
    }

    func handleProductsResult(_ result: Result<Products?, Error>) {
        switch result {
            case .success(let products):
                if let products = products {
                    DispatchQueue.main.async {
                        self.products = products
                        self.collectionView.reloadData()
                    }
                } else {
                    showErrorAlert(withMessage: "Success, but no products found.")
                }

            case .failure(let error):
                showErrorAlert(withMessage: "Error: \(error.localizedDescription)")
        }
    }
}

// MARK: - Setup Constraints
extension CatalogViewController {
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
