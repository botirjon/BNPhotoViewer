//
//  BNPhotoViewerDataSource.swift
//  BNPhotoViewer
//
//  Created by Botirjon Nasridinov on 06/03/23.
//

import Foundation

public protocol BNPhotoViewerDataSource {

    func numberOfPhotos(in photoViewer: BNPhotoViewer) -> Int
    
    func photoViewer(_ photoViewer: BNPhotoViewer, titleForPhotoAt index: Int) -> String?
    
    func photoViewer(_ photoViewer: BNPhotoViewer, detailForPhotoAt index: Int) -> String?
    
    func photoViewer(_ photoViewer: BNPhotoViewer, leftTopBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction]
    
    func photoViewer(_ photoViewer: BNPhotoViewer, rightTopBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction]
    
    func photoViewer(_ photoViewer: BNPhotoViewer, bottomBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction]
}


public extension BNPhotoViewerDataSource {
    func numberOfPhotos(in photoViewer: BNPhotoViewer) -> Int { 0 }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, titleForPhotoAt index: Int) -> String? { nil }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, detailForPhotoAt index: Int) -> String? { nil }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, leftTopBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction] { [] }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, rightTopBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction] { [] }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, bottomBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction] { [] }
}
