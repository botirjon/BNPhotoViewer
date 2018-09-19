//
//  BNPhotoViewer.swift
//  BNPhotoViewer
//
//  Created by botirjon nasridinov on 11/09/2018.
//  Copyright © 2018 Orient Software Team. All rights reserved.
//

import UIKit

public class BNPhotoViewer: UIViewController {
    
    /*
     * MARK: - UI Properties
     */
    
    // views
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var photoList: UICollectionView!
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var topOffsetView: UIView!
    @IBOutlet weak var topBar: UINavigationBar!
    
    @IBOutlet weak var bottomContainer: BNPassThroughView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var detailBar: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var bottomOffsetView: UIView!
    
    // constraints
    @IBOutlet weak var topOffsetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomBarLeading: NSLayoutConstraint!
    @IBOutlet weak var detailLabelTop: NSLayoutConstraint!
    @IBOutlet weak var detailLabelBottom: NSLayoutConstraint!
    @IBOutlet weak var bottomBarHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomOffsetViewHeight: NSLayoutConstraint!
    
    /*
     * MARK: - Properties
     */
    struct Attributes {
        // metrics
        static let detailLabelTopOffsetValue: CGFloat = 8.0
        static let preferredTopOffsetViewHeightValue: CGFloat = 20.0
        static let bottomBarHeightValue: CGFloat = 44.0
        static let barTransparencyValue: CGFloat = 0.6
        static let minimumZoomScale: CGFloat = 0.2
        static let maximumZoomScale: CGFloat = 5.0
        
        static let bottomBarButtonSizeValue: CGFloat = 30.0
        static let bottomBarButtonMargin: CGFloat = 0.0
        
        static let preferredAnimationDuration: TimeInterval = 0.2
        static let shortAnimationDuration: TimeInterval = Attributes.preferredAnimationDuration
        static let longAnimationDuration: TimeInterval = Attributes.preferredAnimationDuration + 0.1
        
        // colors
        static let textColor: UIColor = .white
        static let imageColor: UIColor = .white
        static let barColor: UIColor = UIColor.black.withAlphaComponent(Attributes.barTransparencyValue)
        static let containerBackgroundColor: UIColor = .clear
        static let photoListBackgroundColor: UIColor = .clear
    }
    
    lazy var photoListLayout: BNPhotoListLayout = {
        let photoListLayout = BNPhotoListLayout()
        return photoListLayout
    }()
    
    public var delegate: BNPhotoViewerDelegate?
    
    public var initialIndex: Int = 0
    public var visibleItemIndex: Int {
        return currentIndex
    }
    
    var isInitialItemSet: Bool = false
    var currentIndex: Int = 0 {
        didSet {
            // TODO
        }
    }
    var bottomBarButtons: [BNEasy2TapButton] = []
    
    var isDetailed: Bool = false {
        didSet {
            updateDisplayItems(isDetailed: isDetailed, animated: true)
            state = isDetailed ? .detailed : .regular
        }
    }
    
    var recentOrientation: UIInterfaceOrientation?
    var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var hasTitle: Bool = false
    var hasTopBarItems: Bool = false
    var isPanning: Bool = false {
        didSet {
            if !isPanning {
                if !isDetailed && !containerPositionDisturbed {
                    showBars(animated: true)
                }
            }
            else {
                if !isDetailed && containerPositionDisturbed {
                    hideBars(animated: true)
                }
            }
        }
    }
    var containerPositionDisturbed: Bool = false
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var state: BNPhotoViewerState = .regular {
        didSet {
            delegate?.photoViewer(self, didChangeState: state)
        }
    }
    var isDoneArrangingBottomBarButtons: Bool = false
    var viewSize: CGSize?
    var trueStatusBarHeight: CGFloat = 0
    
    /*
     * MARK: - Init
     */
    
    static let nibName = "BNPhotoViewer"
    static let bundleName = "BNPhotoViewer"
    static let photoCellId = "photoCell"
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        var bundle: Bundle?
        let podBundle = Bundle.init(for: BNPhotoViewer.self)
        if let bundleURL = podBundle.url(forResource: BNPhotoViewer.bundleName, withExtension: "bundle") {
            bundle = Bundle.init(url: bundleURL)
        }
        else {
            assert(false, "Could find the bundle")
        }
        super.init(nibName: BNPhotoViewer.nibName, bundle: bundle)
        
        initSelf()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
        saveNonZeroStatusBarHeight()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fixViewFrame(withSize: trueViewSize)
        reloadData()
        saveNonZeroStatusBarHeight()
        updateTopOffset()
        setInitialItem()
        updateDisplayItems()
        fixColors()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fixContentOffset()
        if let viewSize = self.viewSize {
            fixBottomBarFrame(withViewSize: viewSize)
        }
        updateDisplayItems()
        saveNonZeroStatusBarHeight()
        updateTopOffset()
        recentOrientation = orientation
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        fixViewFrame(withSize: size)
        viewSize = size
        saveNonZeroStatusBarHeight()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearOnClose()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photoViewerDidClose?()
        delegate?.photoViewerDidClose()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public override var prefersStatusBarHidden: Bool {
        if isLandscape {
            return true
        }
        else {
            return shouldHideStatusBar
        }
    }
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
}
