//
//  TodoCell.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/28.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

protocol TodoCellDelegate: class {
    func checkTapped(tag: Int)
}

final class TodoCell: UITableViewCell {

    static let identifier = "todo"
    
    weak var delegate: TodoCellDelegate? = nil
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var content: UILabel!
    
    var todo: Todo? {
        didSet {
            if let todo = todo {
                content.text = todo.content
                checkButton.isSelected = todo.isCompleted
                shouldStrikeThroughString(todo.isCompleted)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func checkTapped(_ sender: UIButton) {
        delegate?.checkTapped(tag: tag)
    }
    
    func shouldStrikeThroughString(_ strikeThrough: Bool) {
        guard let text = content.text else {
            return
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        
//        checkButton.isAccessibilityElement = false
        
        if strikeThrough {
            content.accessibilityLabel = "Completed: \(text)"
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        } else {
            content.accessibilityLabel = "Uncompleted: \(text)"
        }
        
        checkButton.isSelected = strikeThrough
        content.attributedText = attributedString
    }
}
