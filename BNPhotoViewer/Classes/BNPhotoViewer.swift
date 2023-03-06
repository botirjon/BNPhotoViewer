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
//    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var detailBar: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var bottomOffsetView: UIView!
    @IBOutlet weak var bottomActionsStack: UIStackView!
    
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
    
    public var delegate: BNPhotoViewerDelegate?
    public var dataSource: BNPhotoViewerDataSource?
    
    var isInitialItemSet: Bool = false
    var currentIndex: Int = 0
    var bottomBarButtons: [BNEasy2TapButton] = []
    var recentOrientation: UIInterfaceOrientation?
    var isStatusBarHidden: Bool = false
    var hasTitle: Bool = false
    var hasTopBarItems: Bool = false
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var isDoneArrangingBottomBarButtons: Bool = false
    var viewSize: CGSize?
    var trueStatusBarHeight: CGFloat = 0
    
    lazy var photoListLayout: BNPhotoListLayout = {
        let photoListLayout = BNPhotoListLayout()
        return photoListLayout
    }()
    
    var _initialItemIndex: Int = 0 {
        didSet {
            if !isInitialItemSet {
                isInitialItemSet = false
            }
        }
    }
    
    public var initialItemIndex: Int {
        set {
            guard !isInitialItemSet else {
                return
            }
            if isValidIndex(newValue) {
                _initialItemIndex = newValue
            }
            else {
                _initialItemIndex = 0
            }
        }
        get {
            return _initialItemIndex
        }
    }
    
    var isDetailed: Bool = false {
        didSet {
            state = isDetailed ? .detailed : .regular
        }
    }
    
    var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var isPanning: Bool = false {
        didSet {
            if !isPanning {
                if !isDetailed && !containerPositionDisturbed {
                    state = .dragDownEnded
                }
            }
            else {
                if !isDetailed && containerPositionDisturbed {
                    state = .dragDownBegan
                }
                else if !isDetailed && !containerPositionDisturbed {
                    state = .dragDownIdle
                }
            }
        }
    }
    
    var containerPositionDisturbed: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var state: BNPhotoViewerState = .regular {
        didSet {
            updateDisplayItems(forState: state, animated: isViewLoaded)
            delegate?.photoViewer(self, didChangeState: state)
        }
    }
    
    
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
        clear()
        go(toItemAt: initialItemIndex)
        reloadData()
        saveNonZeroStatusBarHeight()
        updateTopOffset()
        updateDisplayItems()
        fixColors()
    }
    
    private var didLayoutOnce: Bool = false
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fixContentOffset()
        if let viewSize = self.viewSize {
            fixBottomBarFrame(withViewSize: viewSize)
        }
        if !didLayoutOnce {
            updateDisplayItems()
            didLayoutOnce = true
        }
        saveNonZeroStatusBarHeight()
        updateTopOffset()
        recentOrientation = orientation
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        fixViewFrame(withSize: size)
        viewSize = size
        updateDisplayItems(forItemAt: currentIndex)
        saveNonZeroStatusBarHeight()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBarView?.alpha = 1
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photoViewerDidClose?()
        delegate?.photoViewerDidClose()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return containerPositionDisturbed ? .default : .lightContent
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
    
    @objc
    internal func topBarLeftButtonTapped(_ sender: BNPhotoViewerActionButton) {
        if let indexPath = sender.indexPath {
            sender.action?.handler?(indexPath)
            delegate?.photoViewer(self, didSelectLeftTopBarActionAt: indexPath)
        }
    }
    
    @objc
    internal func topBarRightButtonTapped(_ sender: BNPhotoViewerActionButton) {
        if let indexPath = sender.indexPath {
            sender.action?.handler?(indexPath)
            delegate?.photoViewer(self, didSelectRightTopBarActionAt: indexPath)
        }
    }
    
    @objc
    internal func bottomBarButtonTapped(_ sender: BNPhotoViewerActionButton) {
        if let indexPath = sender.indexPath {
            sender.action?.handler?(indexPath)
            delegate?.photoViewer(self, didSelectBottomBarActionAt: indexPath)
        }
    }
}
