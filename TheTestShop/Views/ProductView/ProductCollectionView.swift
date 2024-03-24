//
//  ProductCollectionView.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import UIKit

final class ProductCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        if let layout = layout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumInteritemSpacing = ConstantsProductCollection.minSpacing
            layout.minimumLineSpacing = ConstantsProductCollection.minSpacing
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: (frame.size.width/2) - 16 , height: ConstantsProductCollection.itemHeight)
            register(ProductViewCell.self, forCellWithReuseIdentifier: ProductViewCell.identifier)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constants
fileprivate struct ConstantsProductCollection {
    static let minSpacing: CGFloat = 8
    static let itemHeight: CGFloat = 300
}
