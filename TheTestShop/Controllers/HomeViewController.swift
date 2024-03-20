//
//  HomeViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let searchBar = UISearchBar()
    private let horizontalSlider = HorizontalSliderView()

    private lazy var collectionView: ProductCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = ProductCollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupConfiguration()
        setupConstraints()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewCell.identifier, for: indexPath) as! ProductViewCell
        cell.configure()
        return cell
    }
}

// MARK: - Private methods

private extension HomeViewController {
    
    func setupConfiguration() {
        view.addSubview(horizontalSlider)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    
    func setupConstraints() {
        horizontalSlider.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            horizontalSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalSlider.heightAnchor.constraint(equalToConstant: 150),
            
            collectionView.topAnchor.constraint(equalTo: horizontalSlider.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

