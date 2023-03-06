//
//  ViewController.swift
//  BNPhotoViewer
//
//  Created by botirjon on 03/03/2023.
//  Copyright (c) 2023 botirjon. All rights reserved.
//

import UIKit
import BNPhotoViewer
import Kingfisher

class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Open", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(openPhotoViewer), for: .touchUpInside)
        return button
    }()
    
    private lazy var images: [URL] = {
        return (0..<10).map { seed in
            URL(string: "https://picsum.photos/seed/\(seed)/200/300")!
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: button.superview!.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: button.superview!.centerYAnchor)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    private func openPhotoViewer() {
        let photoViewer = BNPhotoViewer()
        photoViewer.dataSource = self
        photoViewer.delegate = self
        present(photoViewer, animated: true)
    }
    
    var actions: (Int) -> [BNPhotoViewerAction] = { (index) in
        return [
            .init(image: .init(named: "icon.trash")),
            .init(image: .init(named: "icon.trash")),
            .init(image: .init(named: "icon.trash"))
        ]
    }
}



extension ViewController: BNPhotoViewerDataSource {
    func numberOfPhotos(in photoViewer: BNPhotoViewer) -> Int {
        return images.count
    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, bottomBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction] {
        return self.actions(index)
    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, leftTopBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction] {
        return [
            .init(image: .init(named: "icon.trash"))
        ]
    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, rightTopBarActionsForPhotoAt index: Int) -> [BNPhotoViewerAction] {
        return [
            .init(image: .init(named: "icon.trash"))
        ]
    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, titleForPhotoAt index: Int) -> String? {
        "Photo \(index)"
    }
}

extension ViewController: BNPhotoViewerDelegate {
    
    func photoViewer(_ photoViewer: BNPhotoViewer, shouldConfigureImageView imageView: UIImageView, forPhotoAt index: Int) {
        imageView.kf.setImage(with: images[index])
    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, shouldConfigureBottomBarButton button: UIButton, at position: Int, forPhotoAt index: Int) {
        button.backgroundColor = .red
    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectLeftTopBarActionAt indexPath: IndexPath) {
        print("Left topbar action tapped: \(indexPath)")
    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectRightTopBarActionAt indexPath: IndexPath) {
        print("Right topbar action tapped: \(indexPath)")
    }
    
    func photoViewer(_ photoViewer: BNPhotoViewer, didSelectBottomBarActionAt indexPath: IndexPath) {
        print("bottombar action tapped: [action: \(indexPath.row), photo: \(indexPath.section)]")
    }
}
