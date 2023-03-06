//
//  BNPhotoViewer+ScrollView.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public extension BNPhotoViewer {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let visibleIndex = self.visibleIndex else {
            return
        }
        if orientation == recentOrientation {
            if currentIndex != visibleIndex {
                currentIndex = visibleIndex
                updateDisplayItems()
            }
        }
        else {
            updateDisplayItems()
        }
    }
}
