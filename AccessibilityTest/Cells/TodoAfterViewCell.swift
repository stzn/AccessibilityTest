//
//  TodoCell.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/28.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

protocol TodoAfterCellDelegate: class {
    func checkTapped(tag: Int)
}

final class TodoAfterCell: UITableViewCell {
    
    static let identifier = "todoafter"
    
    weak var delegate: TodoAfterCellDelegate? = nil
    var tapGesture: UITapGestureRecognizer!

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
        setAction()
    }
    
    private func setAction() {
        tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(cellLongPressed))
        addGestureRecognizer(tapGesture)
    }
    
    
    @IBAction func checkTapped(_ sender: UIButton) {
        delegate?.checkTapped(tag: tag)
    }
    
    func shouldStrikeThroughString(_ strikeThrough: Bool) {
        guard let text = content.text else {
            return
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        
        checkButton.isAccessibilityElement = false
        
        if strikeThrough {
            content.accessibilityLabel = "完了: \(text)"
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        } else {
            content.accessibilityLabel = "未完了: \(text)"
        }
        
        checkButton.isSelected = strikeThrough
        content.attributedText = attributedString
    }
    
    @objc func cellLongPressed() {
        delegate?.checkTapped(tag: tag)
    }
}
