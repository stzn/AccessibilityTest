//
//  HomeworkDatasource.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/28.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

struct HomeworkDatasource {
    
    static func homeworks() -> [Homework] {
        guard let path = Bundle.main.path(forResource: "Homeworks", ofType: "plist") else {
            return []
        }
        let url = URL(fileURLWithPath: path)
        if let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            return (try? decoder.decode([Homework].self, from: data)) ?? []
        }
        return []
    }
}
