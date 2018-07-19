//
//  SunflowerRecord.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/07/19.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation
import UIKit


struct SunflowerRecord: BarEntry {

    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        return f
    }()

    var color: UIColor {
        return barColor
    }
    
    var height: Float {
        return value
    }
    
    var text: String {
        return "\(Int(value * 100))cm"
    }
    
    var title: String {
        return formatter.string(from: date)
    }
    
    let date: Date
    let value: Float
    let barColor: UIColor
}

extension SunflowerRecord {
    
    static func loadData() -> [SunflowerRecord] {
        return [
            SunflowerRecord(date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 30), value: 0.1, barColor: .orange),
            SunflowerRecord(date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 31), value: 0.2, barColor: .red),
            SunflowerRecord(date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 32), value: 0.3, barColor: .blue),
            SunflowerRecord(date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 33), value: 0.4, barColor: .green),
            SunflowerRecord(date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 34), value: 0.5, barColor: .yellow),
            SunflowerRecord(date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 35), value: 0.6, barColor: .magenta),
            SunflowerRecord(date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 36), value: 0.7, barColor: .purple),
        ]
    }
}
