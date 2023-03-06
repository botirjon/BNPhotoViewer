//
//  BNPhotoViewerDelegate.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 11/09/2018.
//  Copyright © 2018 Orient Software Team. All rights reserved.
//

import Foundation

public protocol BNPhotoViewerDelegate {
    
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - returns: Number of items to display in `photoViewer`.
     */
//    @available(*, deprecated, message: "This method is deprecated. Please use `func numberOfItems(in photoViewer: BNPhotoViewer) -> Int` in the BNPhotoViewerDataSource instead.")
//    func numberOfItems(in photoViewer: BNPhotoViewer) -> Int
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which the number of actions is requested in `photoViewer`.
     - returns: The number of actions for an item at `index`.
     */
//    @available(*, deprecated, message: "This method is deprecated. Please use data source method `func photoViewer(_ photoViewer: BNPhotoViewer, bottomBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction]` instead.")
//    func numberOfBottomBarItems(in photoViewer: BNPhotoViewer, forItemAt index: Int) -> Int
    
    // MARK: - Delegate
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object providing this information.
     - parameter imageView: An image view provided for customization to display an item at `index`.
     - parameter index: An index number identifying the index of an item for which an image view is provided in `photoViewer`.
     */
//    @available(*, deprecated, message: "This method is deprecated. Please use `func photoViewer(_ photoViewer: BNPhotoViewer, shouldConfigureImageView: UIImageView, at index: Int)`")
//    func photoViewer(_ photoViewer: BNPhotoViewer, imageView: UIImageView, at index: Int)
    
    
    func photoViewer(_ photoViewer: BNPhotoViewer, shouldConfigureImageView imageView: UIImageView, forPhotoAt index: Int)
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which left top bar items are requested in `photoViewer`.
     - returns: An array of left top bar items.
     */
//    @available(*, deprecated, message: "This method is deprecated. Please use data source method `func photoViewer(_ photoViewer: BNPhotoViewer, leftTopBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction]` instead.")
//    func photoViewer(_ photoViewer: BNPhotoViewer, leftTopBarItemsAt index: Int) -> [UIBarButtonItem]
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which right top bar items are requested in `photoViewer`.
     - returns: An array of right top bar items.
     */
//    @available(*, deprecated, message: "This method is deprecated. Please use data source method `func photoViewer(_ photoViewer: BNPhotoViewer, rightTopBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction]` instead.")
//    func photoViewer(_ photoViewer: BNPhotoViewer, rightTopBarItemsAt index: Int) -> [UIBarButtonItem]
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object providing this information.
     - parameter button: An action button at a position provided for customization in `photoViewer`.
     - parameter position: The position of the provided action button for an item at an `index`.
     - parameter index: An index number identifying the index of an item for which an action button at a position is provided in `photoViewer`.
     */
//    @available(*, deprecated, message: "This method will be removed soon. Please use `func photoViewer(_ photoViewer: BNPhotoViewer, shouldConfigureBottomBarButton button: UIButton, at position: Int, forItemAt index: Int)` instead to configure the bottom bar button.")
//    func photoViewer(_ photoViewer: BNPhotoViewer, bottomBarButton button: UIButton, at position: Int, forItemAt index: Int)
    
    /**
     Provides the action bar button at a position for an item at an index for customization in a photo viewer.
     - parameter photoViewer: The photo viewer controller object providing this information.
     - parameter button: An action button at a position provided for customization in `photoViewer`.
     - parameter position: The position of the provided action button for an item at an `index`.
     - parameter index: An index number identifying the index of an item for which an action button at a position is provided in `photoViewer`.
     */
    func photoViewer(_ photoViewer: BNPhotoViewer, shouldConfigureBottomBarButton button: UIButton, at position: Int, forPhotoAt index: Int)
    
    /**
     Tells the delegate to return the title text for an item at a particular index in a photo viewer controller.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which a title text is requested in `photoViewer`.
     - returns: title text for an item at `index`.
     */
//    @available(*, deprecated, message: "This method is deprecated. Please use data source method `func photoViewer(_ photoViewer: BNPhotoViewer, titleForPhotoAt index: Int) -> String?` instead.")
//    func photoViewer(_ photoViewer: BNPhotoViewer, titleForItemAt index: Int) -> String
    
    /**
     Tells the delegate to return the caption text for an item at a particular index in a photo viewer controller.
     - parameter photoViewer: The photo viewer controller object requesting this information.
     - parameter index: An index number identifying the index of an item for which a caption text is requested in `photoViewer`.
     - returns: caption text for an item at `index`.
     */
//    @available(*, deprecated, message: "This method is deprecated. Please use data source method `func photoViewer(_ photoViewer: BNPhotoViewer, detailForPhotoAt index: Int) -> String?` instead.")
//    func photoViewer(_ photoViewer: BNPhotoViewer, detailForItemAt index: Int) -> String
    
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
    
    // MARK: - New methods
    
    /// Informs the delegate that left top bar action at indexPath is selected.
    /// - Parameters:
    ///   - photoViewer: The photo viewer instance broadcasting the information.
    ///   - indexPath: indexPath of the selected action.
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectLeftTopBarActionAt indexPath: IndexPath)
    
    /// Informs the delegate that right top bar action at indexPath is selected.
    /// - Parameters:
    ///   - photoViewer: The photo viewer instance broadcasting the information.
    ///   - indexPath: indexPath of the selected action.
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectRightTopBarActionAt indexPath: IndexPath)
    
    /// Informs the delegate that bottom bar action at indexPath is selected.
    /// - Parameters:
    ///   - photoViewer: The photo viewer instance broadcasting the information.
    ///   - indexPath: indexPath of the selected action.
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectBottomBarActionAt indexPath: IndexPath)
}

public extension BNPhotoViewerDelegate {
    // Optional protocol methods
    func photoViewerDidClose() {}
    func photoViewer(_ photoViewer: BNPhotoViewer, didChangeState state: BNPhotoViewerState) {}
    
//    func numberOfItems(in photoViewer: BNPhotoViewer) -> Int { 0 }
//    func numberOfBottomBarItems(in photoViewer: BNPhotoViewer, forItemAt index: Int) -> Int { 0 }
//
//    func photoViewer(_ photoViewer: BNPhotoViewer, leftTopBarItemsAt index: Int) -> [UIBarButtonItem] {
//        []
//    }
//
//    func photoViewer(_ photoViewer: BNPhotoViewer, rightTopBarItemsAt index: Int) -> [UIBarButtonItem] {
//        []
//    }
//
//    func photoViewer(_ photoViewer: BNPhotoViewer, bottomBarButton button: UIButton, at position: Int, forItemAt index: Int) {}
//
//    func photoViewer(_ photoViewer: BNPhotoViewer, titleForItemAt index: Int) -> String {
//        ""
//    }
//
//    func photoViewer(_ photoViewer: BNPhotoViewer, detailForItemAt index: Int) -> String {
//        ""
//    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, shouldConfigureImageView imageView: UIImageView, forPhotoAt index: Int) {}
    
    func photoViewer(_ photoViewer: BNPhotoViewer, shouldConfigureBottomBarButton button: UIButton, at position: Int, forPhotoAt index: Int) {}
    
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectLeftTopBarActionAt indexPath: IndexPath) {}
    
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectRightTopBarActionAt indexPath: IndexPath) {}
    
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectBottomBarActionAt indexPath: IndexPath) {}
}
