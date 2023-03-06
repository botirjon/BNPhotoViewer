//
//  BNPhotoViewerAction.swift
//  BNPhotoViewer
//
//  Created by Botirjon Nasridinov on 06/03/23.
//

import Foundation

public typealias BNPhotoViewerActionHandler = (IndexPath) -> Void

public protocol AnyBNPhotoViewerAction {
    var title: String? { get }
    var image: UIImage? { get }
    var handler: BNPhotoViewerActionHandler? { get }
}

public struct BNPhotoViewerAction: AnyBNPhotoViewerAction {
    public var title: String?
    
    public var image: UIImage?
    
    public var handler: BNPhotoViewerActionHandler?
    
    public init(title: String? = nil, image: UIImage? = nil, handler: BNPhotoViewerActionHandler? = nil) {
        self.title = title
        self.image = image
        self.handler = handler
    }
}
