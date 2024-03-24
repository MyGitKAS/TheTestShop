//
//  CartCollectionView.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 25.03.24.
//

import UIKit


final class CartCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        if let layout = layout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: frame.size.width - 20, height: ConstantsCartCollection.itemHeight)
            register(ProductCartCell.self, forCellWithReuseIdentifier: ProductCartCell.identifier)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constants
fileprivate struct ConstantsCartCollection {
    static let itemHeight: CGFloat = 100
}

