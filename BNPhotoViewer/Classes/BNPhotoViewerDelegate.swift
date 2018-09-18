//
//  BNPhotoViewerDelegate.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 11/09/2018.
//  Copyright © 2018 Orient Software Team. All rights reserved.
//

import Foundation

public protocol BNPhotoViewerDelegate {
    // MARK: - Data Source
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - returns: Number of items to display in `photoViewer`.
     */
    func numberOfItems(in photoViewer: BNPhotoViewer) -> Int
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which the number of actions is requested in `photoViewer`.
     - returns: The number of actions for an item at `index`.
     */
    func numberOfBottomBarItems(in photoViewer: BNPhotoViewer, forItemAt index: Int) -> Int
    
    // MARK: - Delegate
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object providing this information.
     - parameter imageView: An image view provided for customization to display an item at `index`.
     - parameter index: An index number identifying the index of an item for which an image view is provided in `photoViewer`.
     */
    func photoViewer(_ photoViewer: BNPhotoViewer, imageView: UIImageView, at index: Int)
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which left top bar items are requested in `photoViewer`.
     - returns: An array of left top bar items.
     */
    func photoViewer(_ photoViewer: BNPhotoViewer, leftTopBarItemsAt index: Int) -> [UIBarButtonItem]
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which right top bar items are requested in `photoViewer`.
     - returns: An array of right top bar items.
     */
    func photoViewer(_ photoViewer: BNPhotoViewer, rightTopBarItemsAt index: Int) -> [UIBarButtonItem]
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object providing this information.
     - parameter button: An action button at a position provided for customization in `photoViewer`.
     - parameter position: The position of the provided action button for an item at an `index`.
     - parameter index: An index number identifying the index of an item for which an action button at a position is provided in `photoViewer`.
     */
    func photoViewer(_ photoViewer: BNPhotoViewer, bottomBarButton button: UIButton, at position: Int, forItemAt index: Int)
    
    /**
     Tells the delegate to return the title text for an item at a particular index in a photo viewer controller.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which a title text is requested in `photoViewer`.
     - returns: title text for an item at `index`.
     */
    func photoViewer(_ photoViewer: BNPhotoViewer, titleForItemAt index: Int) -> String
    
    /**
     Tells the delegate to return the caption text for an item at a particular index in a photo viewer controller.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which a caption text is requested in `photoViewer`.
     - returns: caption text for an item at `index`.
     */
    func photoViewer(_ photoViewer: BNPhotoViewer, detailForItemAt index: Int) -> String
    
    /**
    Informs when the photoViewer is closed
    */
    
    func photoViewerDidClose()
    
    /**
     Informs when the photoViewer changes its state: either `detailed` or `regular`
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter state: The state `photoViewer` has changed to.
     */
    
    func photoViewer(_ photoViewer: BNPhotoViewer, didChangeState state: BNPhotoViewerState)
}

public extension BNPhotoViewerDelegate {
    // Optional protocol methods
    func photoViewerDidClose() {}
    func photoViewer(_ photoViewer: BNPhotoViewer, didChangeState state: BNPhotoViewerState) {}
}
