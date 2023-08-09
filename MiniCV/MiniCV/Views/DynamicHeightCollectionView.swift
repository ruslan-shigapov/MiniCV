//
//  DynamicHeightCollectionView.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 08.08.2023.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        collectionViewLayout.collectionViewContentSize
    }
}
