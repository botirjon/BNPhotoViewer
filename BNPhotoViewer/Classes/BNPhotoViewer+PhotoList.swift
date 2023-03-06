//
//  BNPhotoViewer+CollectionView.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

extension BNPhotoViewer: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfPhotos(in: self) ?? 0
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BNPhotoViewer.photoCellId, for: indexPath) as! BNPhotoCell
        let imageView = UIImageView()
        
        delegate?.photoViewer(self, shouldConfigureImageView: imageView, forPhotoAt: indexPath.row)
        if let imageView = cell.imageView,
           indexPath.row < self.collectionView(collectionView, numberOfItemsInSection: indexPath.section) {
            delegate?.photoViewer(self, shouldConfigureImageView: imageView, forPhotoAt: indexPath.row)
        }

        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return trueContentOffset
    }
}
