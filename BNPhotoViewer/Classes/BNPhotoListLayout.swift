//
//  BNPhotoListLayout.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public class BNPhotoListLayout: UICollectionViewFlowLayout {
    let innerSpace: CGFloat = 0.0
    var mostRecentOffset: CGPoint = CGPoint()
    
    override init() {
        super.init()
        self.minimumInteritemSpacing = innerSpace
        self.minimumLineSpacing = 0.0
        self.scrollDirection = .horizontal
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var itemWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.frame.size.width
    }
    
    var itemHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.frame.size.height
    }
    
    override public var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
}
