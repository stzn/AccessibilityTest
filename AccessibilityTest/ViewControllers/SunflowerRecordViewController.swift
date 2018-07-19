//
//  SunflowerRecordViewController.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/07/19.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

class SunflowerRecordViewController: UIViewController {

    
    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.entries = SunflowerRecord.loadData()
    }
}
