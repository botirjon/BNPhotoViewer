//
//  BNPhotoViewer+Metrics.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

extension BNPhotoViewer {
    
    fileprivate func numberOfPhotos() -> Int {
        dataSource?.numberOfPhotos(in: self) ?? 0
    }
    
    var trueViewSize: CGSize {
        return viewSize(for: orientation)
    }
    
    func viewSize(for orientation: UIInterfaceOrientation) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let tempWidth = screenSize.width
        let tempHeight = screenSize.height
        
        var width: CGFloat = tempWidth
        var height: CGFloat = tempHeight
        
        if orientation.isLandscape {
            width = tempWidth > tempHeight ? tempWidth : tempHeight
            height = tempWidth > tempHeight ? tempHeight : tempWidth
        }
        else {
            width = tempWidth < tempHeight ? tempWidth : tempHeight
            height = tempWidth < tempHeight ? tempHeight : tempWidth
        }
        return CGSize.init(width: width, height: height)
    }
    
    func screenWidth(for orientation: UIInterfaceOrientation) -> CGFloat {
        let screenSize = UIScreen.main.bounds.size
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        if orientation.isLandscape {
            return screenHeight
        }
        else {
            return screenWidth
        }
    }
    
    var currentScreenWidth: CGFloat {
        return screenWidth(for: orientation)
    }
    
    func contentOffsetValue(forItemAt index: Int) -> CGFloat? {
        guard index >= 0 && index < self.numberOfPhotos() else {
            return nil
        }
        let screenWidth = currentScreenWidth
        
        let numberOfItems = CGFloat(self.numberOfPhotos())
        let contentWidth = numberOfItems * screenWidth
        var offset = CGFloat(index) * screenWidth
        
        if offset < contentWidth {
            return offset
        }
        else {
            let offsetForLastItem = contentWidth - screenWidth
            offset = offsetForLastItem >= 0 ? offsetForLastItem : 0
            return offset
        }
    }
    
    func contentOffset(forItemAt index: Int) -> CGPoint? {
        guard let contentOffsetValue = contentOffsetValue(forItemAt: index) else {
            return nil
        }
        return CGPoint.init(x: contentOffsetValue, y: 0)
    }
    
    var trueContentOffsetValue: CGFloat {
        return contentOffsetValue(forItemAt: currentIndex) ?? 0
    }
    
    var trueContentOffset: CGPoint {
        return contentOffset(forItemAt: currentIndex) ?? CGPoint.zero
    }
    
    var visibleIndex: Int? {
        var rect = CGRect()
        rect.origin = photoList.contentOffset
        rect.size = photoList.bounds.size
        let point = CGPoint(x: rect.midX, y: rect.midY)
        let indexPath = photoList.indexPathForItem(at: point)
        
        return indexPath?.row
    }
    
    var preferredTopOffsetValue: CGFloat {
        if orientation.isLandscape {
            return 0
        }
        else {
            return trueStatusBarHeight
        }
    }
    
    var preferredBottomOffsetValue: CGFloat {
        return view.layoutMargins.bottom
    }
    
    func spacing(betweenNumberOfItems numberOfItems: Int, ofWidth width: CGFloat, inView view: UIView, withMargin margin: CGFloat) -> CGFloat {
        
        let flexibleSpace = view.frame.width - (2 * width + 2 * margin)
        let floatingItemsCount = numberOfItems - 2
        let freeSpace = flexibleSpace - CGFloat(floatingItemsCount) * width
        let spacing = freeSpace / CGFloat(floatingItemsCount + 1)
        
        return spacing
    }
    
    func spacing(betweenNumberOfItems numberOfItems: Int, ofWidth width: CGFloat, inWidth parentWidth: CGFloat, withMargin margin: CGFloat) -> CGFloat {
        
        let flexibleSpace = parentWidth - (2 * width + 2 * margin)
        let floatingItemsCount = numberOfItems - 2
        let freeSpace = flexibleSpace - CGFloat(floatingItemsCount) * width
        let spacing = freeSpace / CGFloat(floatingItemsCount + 1)
        
        return spacing
    }
}
