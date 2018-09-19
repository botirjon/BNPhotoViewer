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
        topBar.topItem?.title = delegate?.photoViewer(self, titleForItemAt: index)
    }
    
    func setTopBarItems(forItemAt index: Int) {
        guard isValidIndex(index) else {
            return
        }
        let leftBarButtonItems = delegate?.photoViewer(self, leftTopBarItemsAt: index) ?? []
        let rightBarButtonItems = delegate?.photoViewer(self, rightTopBarItemsAt: index) ?? []
        topBar.topItem?.leftBarButtonItems = leftBarButtonItems
        topBar.topItem?.rightBarButtonItems = rightBarButtonItems
    }
    
    func setDetail(forItemAt index: Int) {
        guard isValidIndex(index) else {
            return
        }
        let detailText = delegate?.photoViewer(self, detailForItemAt: index) ?? ""
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
        removeOldBottomBarButtons()
        isDoneArrangingBottomBarButtons = false
        let buttonsCount = delegate?.numberOfBottomBarItems(in: self, forItemAt: index) ?? 0
        
        guard buttonsCount > 0 else {
            bottomBarHeight.constant = 0
            return
        }
        bottomBarHeight.constant = Attributes.bottomBarHeightValue
        for i in 0..<buttonsCount {
            let frame = self.frame(forBottomBarButtonAt: i, buttonsCount: buttonsCount)
            let button = createButton(in: frame)
            bottomBar.addSubview(button)
            bottomBarButtons.append(button)
        }
        isDoneArrangingBottomBarButtons = true
    }
    
    func removeOldBottomBarButtons() {
        for button in bottomBarButtons {
            button.removeFromSuperview()
        }
        bottomBarButtons = []
    }
    
    func frame(forBottomBarButtonAt position: Int, buttonsCount: Int) -> CGRect {
        let spacing = self.spacing(betweenNumberOfItems: buttonsCount,
                                   ofWidth: Attributes.bottomBarButtonSizeValue,
                                   inView: bottomBar,
                                   withMargin: Attributes.bottomBarButtonMargin)
        let y = (Attributes.bottomBarHeightValue - Attributes.bottomBarButtonSizeValue) / 2
        
        if buttonsCount > 1 {
            let x = Attributes.bottomBarButtonMargin + (spacing + Attributes.bottomBarButtonSizeValue) * CGFloat(position)
            return CGRect.init(x: x,
                               y: y,
                               width: Attributes.bottomBarButtonSizeValue,
                               height: Attributes.bottomBarButtonSizeValue)
        }
        else if buttonsCount == 1 {
            return CGRect.init(x: Attributes.bottomBarButtonMargin,
                               y: y,
                               width: Attributes.bottomBarButtonSizeValue,
                               height: Attributes.bottomBarButtonSizeValue)
        }
        else {
            return CGRect.zero
        }
    }
    
    func createButton(in frame: CGRect) -> BNEasy2TapButton {
        let button = BNEasy2TapButton(frame: frame)
        button.backgroundColor = UIColor.clear
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        button.tintColor = Attributes.textColor
        
        return button
    }
    
    func customizeBottomBarButtons(forItemAt index: Int) {
        guard isValidIndex(index) else {
            return
        }
        for (i, button) in bottomBarButtons.enumerated() {
            delegate?.photoViewer(self, bottomBarButton: button, at: i, forItemAt: index)
            if let backgroundImage = button.backgroundImage(for: .normal) {
                button.setBackgroundImage(backgroundImage.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            if let image = button.image(for: .normal) {
                button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            }
        }
    }
    
    func setBottomOffset(forItemAt index: Int) {
        bottomOffsetViewHeight.constant = hasBottom(forItemAt: index) ? preferredBottomOffsetValue : 0
    }
    
    func isValidIndex(_ index: Int) -> Bool {
        guard index >= 0 && index < delegate?.numberOfItems(in: self) ?? 0 else {
            return false
        }
        return true
    }
    
    func hasBottom(forItemAt index: Int) -> Bool {
        guard isValidIndex(index) else {
            return false
        }
        let detail = self.delegate?.photoViewer(self, detailForItemAt: index) ?? ""
        let bottomBarItemsCount = self.delegate?.numberOfBottomBarItems(in: self, forItemAt: index) ?? 0
        return !detail.isEmpty || bottomBarItemsCount > 0
    }
    
    func saveNonZeroStatusBarHeight() {
        if statusBarHeight > 0 {
            trueStatusBarHeight = statusBarHeight
        }
    }
}
