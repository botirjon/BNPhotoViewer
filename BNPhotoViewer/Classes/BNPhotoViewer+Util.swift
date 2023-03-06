//
//  BNPhotoViewer+Util.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public extension BNPhotoViewer {
    
    func setTitle(forItemAt index: Int) {
        guard isValidIndex(index) else {
            return
        }
        topBar.topItem?.title = dataSource?.photoViewer(self, titleForPhotoAt: index)
    }
    
    func setTopBarItems(forItemAt index: Int) {
        guard isValidIndex(index) else {
            return
        }
        
        
        let leftActions = dataSource?.photoViewer(self, leftTopBarActionsForPhotoAt: index) ?? []
        let rightActions = dataSource?.photoViewer(self, rightTopBarActionsForPhotoAt: index) ?? []
        
        
        let leftItems: [UIBarButtonItem] = leftActions.enumerated().map { actionIndex, action in
            let button = BNPhotoViewerActionButton()
            button.indexPath = .init(row: actionIndex, section: index)
            button.action = action
            button.setTitle(action.title, for: .normal)
            button.setImage(action.image, for: .normal)
            button.addTarget(self, action: #selector(topBarLeftButtonTapped(_:)), for: .touchUpInside)
            let item = UIBarButtonItem(customView: button)
            return item
        }
        
        let rightItems: [UIBarButtonItem] = rightActions.enumerated().map { actionIndex, action in
            let button = BNPhotoViewerActionButton()
            button.indexPath = .init(row: actionIndex, section: index)
            button.action = action
            button.setTitle(action.title, for: .normal)
            button.setImage(action.image, for: .normal)
            button.addTarget(self, action: #selector(topBarRightButtonTapped(_:)), for: .touchUpInside)
            let item = UIBarButtonItem(customView: button)
            return item
        }
        
        topBar.topItem?.leftBarButtonItems = leftItems
        topBar.topItem?.rightBarButtonItems = rightItems
    }
    
    func setDetail(forItemAt index: Int) {
        guard isValidIndex(index) else {
            return
        }
        let detailText = dataSource?.photoViewer(self, detailForPhotoAt: index) ?? ""
        detailLabel.text = detailText
        if detailText.isEmpty {
            detailLabelTop.constant = 0
            detailLabelBottom.constant = 0
        }
        else {
            detailLabelTop.constant = Attributes.detailLabelTopOffsetValue
            detailLabelBottom.constant = Attributes.detailLabelTopOffsetValue
        }
    }
    
    func setBottomBarButtons(forItemAt index: Int) {
        self.arrangeBottomBarButtons(forItemAt: index)
        self.customizeBottomBarButtons(forItemAt: index)
    }
    
    func arrangeBottomBarButtons(forItemAt index: Int) {
        guard isValidIndex(index) else {
            return
        }
        isDoneArrangingBottomBarButtons = false
        bottomActionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let bottomActions = dataSource?.photoViewer(self, bottomBarActionsForPhotoAt: index) ?? []
        
        let buttonsCount = bottomActions.count
        
        guard buttonsCount > 0 else {
            bottomBarHeight.constant = 0
            return
        }
        bottomBarHeight.constant = Attributes.bottomBarHeightValue
        
        bottomActions.enumerated().forEach { i, action in
            let button = BNPhotoViewerActionButton()
            button.tintColor = Attributes.textColor
            button.indexPath = .init(row: i, section: index)
            button.action = action
            button.setTitle(action.title, for: .normal)
            button.setImage(action.image, for: .normal)
            button.frame = .init(origin: .zero, size: .init(width: 24, height: 24))
            button.addTarget(self, action: #selector(bottomBarButtonTapped(_:)), for: .touchUpInside)
            bottomActionsStack.addArrangedSubview(button)
        }
        isDoneArrangingBottomBarButtons = true
    }
    
    func customizeBottomBarButtons(forItemAt index: Int) {
        guard isValidIndex(index) else {
            return
        }
        
        bottomActionsStack.arrangedSubviews.enumerated().forEach { buttonIndex, button in
            if let button = button as? BNPhotoViewerActionButton {
                delegate?.photoViewer(self, shouldConfigureBottomBarButton: button, at: buttonIndex, forPhotoAt: index)
                if let backgroundImage = button.backgroundImage(for: .normal) {
                    button.setBackgroundImage(backgroundImage.withRenderingMode(.alwaysTemplate), for: .normal)
                }
                if let image = button.image(for: .normal) {
                    button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
                }
            }
        }
    }
    
    func setBottomOffset(forItemAt index: Int) {
        bottomOffsetViewHeight.constant = hasBottom(forItemAt: index) ? preferredBottomOffsetValue : 0
    }
    
    func isValidIndex(_ index: Int) -> Bool {
        let photosCount = dataSource?.numberOfPhotos(in: self) ?? 0
        guard index >= 0 && index < photosCount else {
            return false
        }
        return true
    }
    
    func hasBottom(forItemAt index: Int) -> Bool {
        guard isValidIndex(index) else {
            return false
        }
        let detail = self.dataSource?.photoViewer(self, detailForPhotoAt: index) ?? ""
        let bottomBarItemsCount = self.dataSource?.photoViewer(self, bottomBarActionsForPhotoAt: index).count ?? 0
        return !detail.isEmpty || bottomBarItemsCount > 0
    }
    
    func saveNonZeroStatusBarHeight() {
        if statusBarHeight > 0 {
            trueStatusBarHeight = statusBarHeight
        }
    }
}
