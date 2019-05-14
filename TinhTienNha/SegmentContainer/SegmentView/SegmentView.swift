//
//  SegmentView.swift
//  Qooco Boost Career
//
//  Created by btanh on 3/26/19.
//  Copyright © 2019 AXON ACTIVE VIETNAM. All rights reserved.
//

import UIKit


@IBDesignable
class SegmentView: UIView {
    
//    @IBInspectable
//    public var leftIcon: UIImage? {
//        didSet {
//            leftImageView.image = leftIcon
//        }
//    }
//
//    @IBInspectable
//    public var rightIcon: UIImage? {
//        didSet {
//            rightImageView.image = rightIcon
//        }
//    }
    
//    @IBInspectable
//    public var leftTitleKey: String? {
//        didSet {
//            leftButtonLabel.localizeKey = leftTitleKey
//            leftButtonLabel.localize()
//        }
//    }
//
//    @IBInspectable
//    public var rightTitleKey: String? {
//        didSet {
//            rightButtonLabel.localizeKey = rightTitleKey
//            rightButtonLabel.localize()
//        }
//    }
//
//    @IBInspectable
//    public var segmentColor: UIColor {
//        didSet {
//            segmentView.backgroundColor = segmentColor
//        }
//    }
    
    // MARK: - IBOutlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var leftSegmentView: UIView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftButtonLabel: UILabel!
    @IBOutlet weak var leftLineView: UIView!
    @IBOutlet weak var rightSegmentView: UIView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightButtonLabel: UILabel!
    @IBOutlet weak var rightLineView: UIView!
    @IBOutlet weak var pagingView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Custom properties
    private var pageViewController: UIPageViewController!
    lazy private var iconCalendar: UIImage? = {
        return rightImageView.image?.withRenderingMode(.alwaysTemplate)
    }()
    lazy private var iconVacancy: UIImage? = {
        return leftImageView.image?.withRenderingMode(.alwaysTemplate)
    }()
    lazy private var grayColor: UIColor = {
//        return UIColor.init(hex: 0xE5747B)
        return .gray
    }()
    
    // MARK: - Public properties
    public var listSubpage: [UIViewController]!
    
    // MARK: - Setup View
    private func commonInit() {
        Bundle.main.loadNibNamed("SegmentView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Active method
    @IBAction func clickLeftButton(_ sender: Any) {
        hightLightView(.tabLeft)
        switchPageview(.tabLeft)
    }
    
    @IBAction func clickRightButton(_ sender: Any) {
        hightLightView(.tabRight)
        switchPageview(.tabRight)
    }
    
}

// MARK: - Support Segment
extension SegmentView {
    private func hightLightView(_ tab: SegmentTab) {
        resetVisibleSegment()
        
        switch tab {
        case .tabLeft:
            leftImageView.image = iconVacancy
            leftImageView.tintColor = .white
            leftButtonLabel.textColor = UIColor.white
            leftLineView.isHidden = false
        case .tabRight:
            rightImageView.image = iconCalendar
            rightImageView.tintColor = .white
            rightButtonLabel.textColor = UIColor.white
            rightLineView.isHidden = false
        }
    }
    
    private func resetVisibleSegment() {
        leftImageView.image = iconVacancy
        leftImageView.tintColor = self.grayColor
        leftButtonLabel.textColor = self.grayColor
        leftLineView.isHidden = true
        
        rightImageView.image = iconCalendar
        rightImageView.tintColor = self.grayColor
        rightButtonLabel.textColor = self.grayColor
        rightLineView.isHidden = true
    }
    
    // Public method
}

// MARK: - Support Pageview
extension SegmentView {
    public func initPageview() {
        guard let initialVC = self.viewControllerAtIndex(0) else { return }
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = self.pagingView.bounds
        let viewControllers: [UIViewController] = [initialVC]
        pageViewController.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        self.pagingView.addSubview(pageViewController.view)
        
        hightLightView(.tabLeft)
    }
    
    private func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        guard let listView = listSubpage, listView.count >= 2 else { return nil }
        
        return listSubpage[index]
    }
    
    private func switchPageview(_ tab: SegmentTab) {
//        let direction: UIPageViewController.NavigationDirection
        let direction: UIPageViewControllerNavigationDirection
        let viewController: UIViewController
        
        switch tab {
        case .tabLeft:
            direction = .reverse
            viewController = viewControllerAtIndex(0) ?? UIViewController()
        case .tabRight:
            direction = .forward
            viewController = viewControllerAtIndex(1) ?? UIViewController()
        }
        
        pageViewController.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }
}
