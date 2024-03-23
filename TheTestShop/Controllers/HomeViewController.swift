//
//  HomeViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 23.03.24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let customCollectionView = CustomCollectionView()
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupConfiguration()
        setupConstraints()
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UISearchBarDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 10 : 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionCell.identifier, for: indexPath) as! SaleCollectionCell
            let img = UIImage(named: "test_sale")!
            cell.configure(image: img, title: "Sale 30%")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewCell.identifier, for: indexPath)
            return cell
        }
    }
}

// MARK: - Private methods
extension HomeViewController {
    
    func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func setupConfiguration() {
        view.addSubview(customCollectionView)
        customCollectionView.collectionView.dataSource = self
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
