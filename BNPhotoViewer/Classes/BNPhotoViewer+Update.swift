//
//  BNPhotoViewer+Update.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public extension BNPhotoViewer {
    
    /*
     * MARK: - Update top
     */
    
    func updateTitle(forItemAt index: Int? = nil) {
        if let index = index {
            setTitle(forItemAt: index)
        }
        else if let visibleIndex = self.visibleIndex {
            setTitle(forItemAt: visibleIndex)
        }
    }
    
    func updateTopBar(forItemAt index: Int? = nil) {
        if let index = index {
            setTopBarItems(forItemAt: index)
        }
        else if let visibleIndex = self.visibleIndex {
            setTopBarItems(forItemAt: visibleIndex)
        }
    }
    
    func updateTopOffset() {
        if orientation != recentOrientation {
            topOffsetViewHeight.constant = preferredTopOffsetValue
        }
    }
    
    /*
     * MARK: - Update bottom
     */
    
    func updateDetail(forItemAt index: Int? = nil) {
        if let index = index {
            setDetail(forItemAt: index)
        }
        else if let visibleIndex = self.visibleIndex {
            setDetail(forItemAt: visibleIndex)
        }
    }
    
    func updateBottomBar(forItemAt index: Int? = nil) {
        if let index = index {
            setBottomBarButtons(forItemAt: index)
        }
        else if let visibleIndex = self.visibleIndex {
            setBottomBarButtons(forItemAt: visibleIndex)
        }
    }
    
    func updateBottomBarButtonFrames() {
        for (index, item) in bottomBarButtons.enumerated() {
            let frame = self.frame(forBottomBarButtonAt: index, buttonsCount: bottomBarButtons.count)
            item.frame = frame
        }
    }
    
    func updateBottomOffset(forItemAt index: Int? = nil) {
        if let index = index {
            setBottomOffset(forItemAt: index)
        }
        else if let visibleIndex = self.visibleIndex {
            setBottomOffset(forItemAt: visibleIndex)
        }
    }
    
    /*
     * MARK: - Fix
     */
    
    func fixFrames(withViewSize size: CGSize) {
        fixViewFrame(withSize: size)
        fixBottomBarFrame(withViewSize: size)
    }
    
    func fixViewFrame(withSize size: CGSize) {
        if modalPresentationStyle == .overCurrentContext {
            self.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        photoListLayout.invalidateLayout()
    }
    
    func restoreToOrigin(animated: Bool = false) {
        let width = self.container.frame.size.width
        let height = self.container.frame.size.height
        if animated {
            UIView.animate(withDuration: Attributes.preferredAnimationDuration) {
                self.container.frame = CGRect(x: 0, y: 0, width: width, height: height)
                self.view.backgroundColor = .black
            }
        }
        else {
            self.container.frame = CGRect(x: 0, y: 0, width: width, height: height)
            self.view.backgroundColor = .black
        }
    }
    
    func fixContentOffset() {
        let insets = photoList.contentInset
        photoList.contentInset = insets

        if orientation != recentOrientation {
            let x = self.view.frame.size.width * CGFloat(currentIndex)
            let point = CGPoint.init(x: x, y: 0)
            photoList.setContentOffset(point, animated: false)
        }
    }
    
    func fixBottomBarFrame(withViewSize size: CGSize) {
        let newBottomBarWidth = size.width - 2 * (view.layoutMargins.left + bottomBarLeading.constant)
        var newFrame = bottomBar.frame
        newFrame.size.width = newBottomBarWidth
        bottomBar.frame = newFrame
    }
    
    func fixColors() {
        topBar.tintColor = Attributes.textColor
        topBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : Attributes.textColor]
        photoList.backgroundColor = Attributes.photoListBackgroundColor
        view.backgroundColor = .black
    }
    /*
     * MARK: - Update utils
     */
    
    func setInitialItem() {
        guard !isInitialItemSet, initialIndex >= 0, initialIndex < delegate?.numberOfItems(in: self) ?? 0 else {
            return
        }
        isInitialItemSet = true
        go(toItemAt: initialIndex)
    }
    
    func updateDisplayItems(forItemAt index: Int? = nil) {
        updateTitle(forItemAt: index)
        updateTopBar(forItemAt: index)
        updateDetail(forItemAt: index)
        updateBottomBar(forItemAt: index)
        updateBottomOffset(forItemAt: index)
    }
    
    func updateDisplayItems(isDetailed: Bool, animated: Bool = false) {
        if isDetailed {
            hideBars(animated: animated)
        }
        else {
            showBars(animated: animated)
        }
    }
    
    func showBars(animated: Bool = false, animationDuration: TimeInterval = 0.2) {
        if animated {
            UIView.animate(withDuration: animationDuration, animations: {
                self.bottomContainer.alpha = 1
                self.topContainer.alpha = 1
                self.shouldHideStatusBar = false
            })
        }
        else {
            bottomContainer.alpha = 1
            topContainer.alpha = 1
            shouldHideStatusBar = false
        }
    }
    
    func hideBars(animated: Bool = false, animationDuration: TimeInterval = 0.2) {
        if animated {
            UIView.animate(withDuration: animationDuration) {
                self.bottomContainer.alpha = 0
                self.topContainer.alpha = 0
                self.shouldHideStatusBar = true
            }
        }
        else {
            bottomContainer.alpha = 0
            topContainer.alpha = 0
            shouldHideStatusBar = true
        }
    }
    
    func restore() {
        bottomContainer.isHidden = false
        topContainer.isHidden = false
        topContainer.alpha = 1.0
        bottomContainer.alpha = 1.0
        shouldHideStatusBar = false
        restore(zoomScaleForItemAt: currentIndex)
    }
    
    func restore(zoomScaleForItemAt index: Int) {
        if let photoCell = photoList.cellForItem(at: IndexPath.init(row: index, section: 0)) as? BNPhotoCell, let scrollView = photoCell.scrollView {
            if scrollView.zoomScale > 0.0 {
                scrollView.setZoomScale(1.0, animated: false)
            }
        }
    }
}
