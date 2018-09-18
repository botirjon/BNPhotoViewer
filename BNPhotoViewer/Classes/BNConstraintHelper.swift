//
//  BNPhotoViewer+ConstraintHelper.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 12/09/2018.
//

import UIKit

public class BNConstraintHelper {
    
    init() {
    }
    
    public static func makeConstraints(for view: UIView, toFitParent parentView: UIView, relativeToMargin: Bool = false) -> [NSLayoutConstraint] {
        let left = NSLayoutConstraint.init(item: view,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: parentView,
                                           attribute: relativeToMargin ? .leftMargin : .left,
                                           multiplier: 1.0,
                                           constant: 0.0)
        
        let right = NSLayoutConstraint.init(item: view,
                                           attribute: .right,
                                           relatedBy: .equal,
                                           toItem: parentView,
                                           attribute: relativeToMargin ? .rightMargin : .right,
                                           multiplier: 1.0,
                                           constant: 0.0)
        
        let top = NSLayoutConstraint.init(item: view,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: parentView,
                                            attribute: relativeToMargin ? .topMargin : .top,
                                            multiplier: 1.0,
                                            constant: 0.0)
        
        let bottom = NSLayoutConstraint.init(item: view,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: parentView,
                                            attribute: relativeToMargin ? .bottomMargin : .bottom,
                                            multiplier: 1.0,
                                            constant: 0.0)
        
        return [left, right, top, bottom]
    }
}
