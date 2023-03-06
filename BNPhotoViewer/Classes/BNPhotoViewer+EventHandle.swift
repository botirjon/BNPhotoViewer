//
//  BNPhotoViewer+EventHandle.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public extension BNPhotoViewer {
    
    @objc func containerSingleTapped(sender: UITapGestureRecognizer) {
        isDetailed = !isDetailed
    }
    
    @objc func containerDoubleTapped(sender: UITapGestureRecognizer) {
        let currentItemIndexPath = IndexPath.init(row: currentIndex, section: 0)
        guard let photoCell = photoList.cellForItem(at: currentItemIndexPath) as? BNPhotoCell else {
            return
        }
        photoCell.doubleTapped(sender: sender)
    }
    
    @objc func viewPanned(sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view.window)
        let state = sender.state
        
        switch state {
        case .began:
            initialTouchPoint = touchPoint
            isPanning = true
            break
            
        case .changed:
            let verticalTranslation: CGFloat = touchPoint.y - initialTouchPoint.y
            if verticalTranslation > 0 {
                container.frame = CGRect(x: 0,
                                         y: verticalTranslation,
                                         width: self.container.frame.size.width,
                                         height: self.container.frame.size.height)
                
                let proportion: CGFloat = verticalTranslation / 20.0
                
                if proportion < 1.0 {
                     self.view.backgroundColor = UIColor.black.withAlphaComponent(1.0 - proportion)
                }
                else if proportion > 1.0 {
                    self.view.backgroundColor = UIColor.clear
                }
                containerPositionDisturbed = true
                isPanning = true
            }
            else {
                restoreToOrigin()
                containerPositionDisturbed = false
                isPanning = true
            }
            break
            
        case .ended, .cancelled:
            let verticalTranslation = touchPoint.y - initialTouchPoint.y
            if verticalTranslation > 100 {
                close(animated: true)
            }
            else {
                restoreToOrigin(animated: true)
                containerPositionDisturbed = false
                isPanning = false
            }
            break
            
        default:
            break
        }
    }
    
    public func close(animated: Bool) {
        dismiss(animated: animated) {
            self.delegate?.photoViewerDidClose()
            self.photoViewerDidClose?()
        }
    }
    
    func dismissFromTop(completion: (() -> Void)?) {
        dismiss(withTransitionType: kCATransitionFromTop, completion: completion)
    }
    
    func dismissFromBottom(completion: (() -> Void)?) {
        dismiss(withTransitionType: kCATransitionFromBottom, completion: completion)
    }
    
    func dismiss(withTransitionType transitionType: String = kCATransitionFromBottom, completion: (() -> Void)?) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = transitionType
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: completion)
    }
    
    func clear() {
        restoreToOrigin()
        restore()
    }
}
