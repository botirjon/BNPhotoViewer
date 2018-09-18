//
//  PhotoCell.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public class BNPhotoCell: UICollectionViewCell {
    var imageView: UIImageView?
    var scrollView: UIScrollView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSelf()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    /*
     * MARK: - Init
     */
    
    func initSelf() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        initScrollView()
        initImageView()
    }
    
    func layout() {
        layoutScrollView()
        layoutImageView()
    }
    
    func initScrollView() {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        scrollView.minimumZoomScale = BNPhotoViewer.Attributes.minimumZoomScale
        scrollView.maximumZoomScale = BNPhotoViewer.Attributes.maximumZoomScale
        
        contentView.addSubview(scrollView)
        self.scrollView = scrollView
    }
    
    func layoutScrollView() {
        setFrame(for: scrollView, toFitParent: self)
    }
    
    func initImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .clear
        scrollView?.addSubview(imageView)
        self.imageView = imageView
    }
    
    func layoutImageView() {
        setFrame(for: imageView, toFitParent: self)
    }
    
    func setFrame(for view: UIView?, toFitParent parent: UIView) {
        var frame = view?.frame
        frame?.size.height = parent.frame.size.height
        frame?.size.width = parent.frame.size.width
        frame?.origin.x = 0
        frame?.origin.y = 0
        view?.frame = frame ?? CGRect.zero
    }
    
    @objc func doubleTapped(sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: scrollView)
        if scrollView?.zoomScale ?? 1.0 > 1.0 {
            scrollView?.setZoomScale(1.0, animated: true)
        }
        else {
            scrollView?.zoom(toPoint: touchPoint, scale: 3.0, animated: true)
        }
    }
}
