//
//  SegmentAppointmentViewController.swift
//  Qooco Boost Career
//
//  Created by btanh on 3/26/19.
//  Copyright © 2019 AXON ACTIVE VIETNAM. All rights reserved.
//

import UIKit

class SegmentAppointmentViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var segmentView: SegmentView!
    
    // MARK: - Custom properties
    
    // MARK: - Public properties
    public var listSubpage: [UIViewController]!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageView()
    }
    
    // MARK: - IBAction
    
    // MARK: - Support method
    private func setupPageView() {
        let subPage0 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        let subPage1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultVC")
        segmentView.listSubpage = [subPage0, subPage1]
        segmentView.initPageview()
    }
}
