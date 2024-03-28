//
//  HomeViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 23.03.24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var products: Products?
    private let customCollectionView = CustomCollectionView()
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
        setupSearchBar()
        setupConfiguration()
        setupConstraints()
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let products = products else { return }
            let vc = ProductFullScreenViewController(product: products[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Prresent sale")
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 10 : products?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionCell.identifier, for: indexPath) as! SaleCollectionCell
            let saleModel = Sale()
            cell.configureWith(model: saleModel)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewCell.identifier, for: indexPath) as! ProductViewCell
            guard let products = products else { return cell }
            cell.configureWithProduct(products[indexPath.row])
            cell.onCartButtonTapped = { CartHolder.addProductInCart(products[indexPath.row]) }
            return cell
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    //TODO: -
}

// MARK: - Private methods
extension HomeViewController {
    
    func getProducts() {
        ShopApiManager.shared.performRequest(for: .getAllProducts) { [weak self] (result: Result<Products?, Error>) in
            guard let self = self else { return }
            switch result {
                case .success(let products):
                    if let products = products {
                        self.products = products
                        DispatchQueue.main.async{
                            self.customCollectionView.collectionView.reloadData()
                        }
                    } else {
                        self.showErrorAlert(withMessage: "Success, but no products found.")
                    }
                case .failure(let error):
                self.showErrorAlert(withMessage: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func setupConfiguration() {
        view.addSubview(customCollectionView)
        customCollectionView.collectionView.dataSource = self
        customCollectionView.collectionView.delegate = self
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
