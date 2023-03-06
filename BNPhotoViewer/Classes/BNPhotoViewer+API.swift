//
//  BNPhotoViewer+API.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public typealias BNBasicAction = () -> Void

public enum BNPhotoViewerState {
    case detailed
    case regular
    case dragDownBegan
    case dragDownEnded
    case dragDownIdle
}

public extension BNPhotoViewer {
    
    private static var apiMethods = [String: Any?]()
    private static let photoViewerDidCloseKey = "photoViewerDidClose"
    
    
    /**
     Called when the photo viewer is closed
     */
    
    public var photoViewerDidClose: BNBasicAction? {
        set {
            BNPhotoViewer.apiMethods[BNPhotoViewer.photoViewerDidCloseKey] = newValue
        }
        get {
            return BNPhotoViewer.apiMethods[BNPhotoViewer.photoViewerDidCloseKey] as? BNBasicAction
        }
    }
    
    /**
     Set the currently displayed item to the one specified by `index`.
     - parameter index: The `index` of the item to display.
     - parameter animated: Whether the operation should be performed with animation
     */
    
    public func go(toItemAt index: Int, animated: Bool = false) {
        guard isViewLoaded, let offset = contentOffset(forItemAt: index) else {
            return
        }
        OperationQueue.main.addOperation {
            self.photoList.setContentOffset(offset, animated: animated)
            self.currentIndex = index
            self.updateDisplayItems(forItemAt: index)
        }
    }
    
    /**
     Reloads the photoViewer data
    */
    
    public func reloadData() {
        OperationQueue.main.addOperation {
            self.photoList.reloadData()
        }
    }
    
    /**
     Index of the currently visible item
     */
    
    public var visibleItemIndex: Int {
        return currentIndex
    }
}
