//
//  BNPhotoViewer+Setup.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 11/09/2018.
//

import UIKit

public extension BNPhotoViewer {
    
    func setupAll() {
        setupView()
        setupTop()
        setupBottom()
        setupContainer()
        setupPhotoList()
    }
    
    // NOTE: - should be called from init
    func initSelf() {
        modalPresentationCapturesStatusBarAppearance = true
        modalPresentationStyle = .overFullScreen
        automaticallyAdjustsScrollViewInsets = false
    }
    
    /*
     * MARK: - Top
     */
    
    func setupTop() {
        setupTopContainer()
        setupTopOffsetView()
        setupTopBar()
    }
    
    func setupTopContainer() {
        topContainer.backgroundColor = Attributes.barColor
    }
    
    func setupTopOffsetView() {
        topOffsetView.backgroundColor = .clear
    }
    
    func setupTopBar() {
        topBar.setBackgroundImage(UIImage(), for: .default)
        topBar.shadowImage = UIImage()
        topBar.isTranslucent = true
        topBar.tintColor = Attributes.textColor
        topBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : Attributes.textColor]
    }
    
    /*
     * MARK: - Bottom
     */
    
    func setupBottom() {
        setupBottomContainer()
        setupDetailBar()
        setupDetailLabel()
        setupBottomBar()
        setupBottomOffsetView()
    }
    
    func setupBottomContainer() {
        bottomContainer.backgroundColor = Attributes.barColor
//        bottomContainer.touchReceivingSubviews.append(bottomBar)
        bottomContainer.touchReceivingSubviews.append(bottomActionsStack)
    }
    
    func setupDetailBar() {
        detailBar.backgroundColor = .clear
        detailBar.isUserInteractionEnabled = false
    }
    
    func setupDetailLabel() {
        detailLabel.lineBreakMode = .byTruncatingTail
        detailLabel.numberOfLines = 0
        detailLabel.textColor = Attributes.textColor
        detailLabel.backgroundColor = .clear
        detailLabel.adjustsFontSizeToFitWidth = false
    }
    
    func setupBottomBar() {
//        bottomBar.backgroundColor = .clear
        bottomActionsStack.backgroundColor = .clear
        bottomActionsStack.alignment = .center
        bottomActionsStack.distribution = .equalSpacing
        bottomActionsStack.axis = .horizontal
    }
    
    func setupBottomOffsetView() {
        bottomOffsetView.backgroundColor = .clear
    }
    
    /*
     * MARK: - Other
     */
    
    func setupView() {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(self.viewPanned(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    func setupContainer() {
        container.backgroundColor = Attributes.containerBackgroundColor
        
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.containerSingleTapped(sender:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        container.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.containerDoubleTapped(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        singleTap.require(toFail: doubleTap)
        container.addGestureRecognizer(doubleTap)
    }
    
    func setupPhotoList() {
        photoList.collectionViewLayout = photoListLayout
        photoList.backgroundColor = Attributes.photoListBackgroundColor
        photoList.showsVerticalScrollIndicator = false
        photoList.showsHorizontalScrollIndicator = false
        photoList.isPagingEnabled = true
        photoList.decelerationRate = UIScrollViewDecelerationRateFast;
        
        photoList.register(BNPhotoCell.self, forCellWithReuseIdentifier: BNPhotoViewer.photoCellId)
        photoList.delegate = self
        photoList.dataSource = self
    }
    
}
