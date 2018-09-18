//
//  BNPassThroughView.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 13/09/2018.
//

import UIKit

public class BNPassThroughView: UIView {
    
    var touchReceivingSubviews: [UIView] = []
    var touchFrames: [CGRect] {
        return touchReceivingSubviews.map({ (v) -> CGRect in
            return v.frame
        })
    }
    
    /*
     * Forward all the touches except the touch points contained in the frames
     * of views provided into `touchReceivingSubviews`
     */
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return touchFrames.contains(where: { (r) -> Bool in
            r.contains(point)
        })
    }
}
