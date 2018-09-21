//
//  PhotoCell.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public class BNPhotoCell: UICollectionViewCell {
    var imageView: UIImageView? {
        didSet {
            layoutInternalImageView(withExternalImageView: imageView)
        }
    }
    
    private var _imageView: UIImageView?
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
        layoutInternalImageView(withExternalImageView: self.imageView)
//        layoutImageView()
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
        self._imageView = imageView
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
    
    func layoutInternalImageView(withExternalImageView imageView: UIImageView? = nil) {
        guard let imageView = imageView else {
            setFrame(for: _imageView, toFitParent: self)
            return
        }
        let frame = self.frame(for: imageView)
        guard frame != CGRect.zero else {
            setFrame(for: _imageView, toFitParent: self)
            return
        }
        layoutInternalImageView(withFrame: frame)
    }
    
    func layoutInternalImageView(withFrame frame: CGRect = CGRect.zero) {
        guard frame != CGRect.zero else {
            setFrame(for: _imageView, toFitParent: self)
            return
        }
        _imageView?.frame = frame
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
    
    func frame(for image: UIImage) -> CGRect {
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let ratio = imageWidth/imageHeight
        let scrollViewHeight = scrollView?.frame.size.height ?? 0
        let scrollViewWidth = scrollView?.frame.size.width ?? 0
        
        if ratio < 1.0 {
            let height = imageHeight > scrollViewHeight ? scrollViewHeight : imageHeight
            let width = height * ratio
            
            let y = (scrollViewHeight - height) / 2
            var x = scrollViewWidth - width
            x = x > 0 ? x / 2 : 0
            let frame = CGRect.init(x: x, y: y, width: width, height: height)
            return frame
        }
        else {
            let width = imageWidth > scrollViewWidth ? scrollViewWidth : imageWidth
            let height = width / ratio
            
            let x = (scrollViewWidth - width) / 2
            var y = scrollViewHeight - height
            y = y > 0 ? y / 2 : 0
            let frame = CGRect.init(x: x, y: y, width: width, height: height)
            return frame
        }
    }
    
    func frame(for imageView: UIImageView) -> CGRect {
        guard let image = imageView.image else {
            return scrollView?.frame ?? CGRect.zero
        }
        return frame(for: image)
    }
}
