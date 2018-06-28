//
//  TodoCell.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/28.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

class HomeworkCell: UITableViewCell {

    static let identifier = "homework"
    
    @IBOutlet weak var todoImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var priority: UILabel!
    @IBOutlet weak var content: UIStackView!
    
    var homework: Homework? {
        didSet {
            if let homework = homework {
                todoImage.image = UIImage(named: homework.imageUrl)
                title.text = homework.title

                switch homework.priority {
                case .norating:
                    priority.text = "☆☆☆☆☆"
                case .rating(let value):
                    let stars = String(repeating: "★", count: value)
                    let noStars = String(repeating: "☆", count: 5 - value)
                    priority.text = "\(stars)\(noStars)"
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
            updateLayoutContraints()
        }
    }
    
    private func updateLayoutContraints() {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory {
            content.axis = .vertical
        } else {
            content.axis = .horizontal
        }
    }
}
