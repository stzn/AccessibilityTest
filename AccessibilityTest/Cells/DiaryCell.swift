//
//  DiaryCell.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/25.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

class DiaryCell: UITableViewCell {
    
    static let identifier = "diary"
    
    private let userName = UILabel()
    private let diaryImage = UIImageView()
    let chatButton = UIButton()
    private let date = UILabel()
    private let weatherImage = UIImageView()
    private let content = UILabel()
    
    private var commonConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var largeConstraints: [NSLayoutConstraint] = []
    private let verticalAnchorConstant: CGFloat = 24.0
    private let horizontalAnchorConstant: CGFloat = 16.0
    
    var diary: Diary? {
        didSet {
            if let diary = diary {
                
                guard let user = (UserDataSource.users().first { $0.id == diary.userId }) else {
                    fatalError("Invalid User")
                }
                
                userName.text = user.name
                
                if let url = diary.imageUrl,
                    let image = UIImage(named: url) {
                    diaryImage.image = image
                }
                
                date.text = diary.date
                
                if let image = UIImage(named: diary.weather) {
                    weatherImage.image = image
                }
                content.text = diary.content
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
        
        contentView.addSubview(diaryImage)
        contentView.addSubview(userName)
        contentView.addSubview(weatherImage)
        contentView.addSubview(date)
        contentView.addSubview(content)
        contentView.addSubview(chatButton)
        
        setupLayoutConstraints()
        updateLayoutContraints()
    }
    
    private func setupViews() {
        
        chatButton.setTitle("コメント", for: .normal)
        chatButton.setTitleColor(chatButton.tintColor, for: .normal)
        chatButton.backgroundColor = .clear
        chatButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        chatButton.layer.borderWidth = 1
        chatButton.layer.borderColor = chatButton.tintColor.cgColor
        chatButton.layer.cornerRadius = 8
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        
        chatButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        chatButton.titleLabel?.adjustsFontForContentSizeCategory = true
        chatButton.setContentHuggingPriority(.required, for: .horizontal)
        
        diaryImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let font = UIFont(name: "Noteworthy", size: 16) {
            content.font = UIFontMetrics.default.scaledFont(for: font)
        }
        content.adjustsFontForContentSizeCategory = true
        content.numberOfLines = 0
        content.translatesAutoresizingMaskIntoConstraints = false
        
        if let font = UIFont(name: "Noteworthy", size: 20) {
            userName.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: font)
            date.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: font)
        }
        userName.adjustsFontForContentSizeCategory = true
        date.adjustsFontForContentSizeCategory = true
        userName.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false

        weatherImage.tintColor = .orange
        weatherImage.adjustsImageSizeForAccessibilityContentSizeCategory = true
        weatherImage.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func setupLayoutConstraints() {
        let heightConstraint = diaryImage.heightAnchor.constraint(equalToConstant: 100)
        heightConstraint.priority = UILayoutPriority(rawValue: 999)
        commonConstraints = [
            diaryImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            diaryImage.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: verticalAnchorConstant),
            diaryImage.widthAnchor.constraint(equalToConstant: 100),
            heightConstraint
        ]
        
        regularConstraints = [
            diaryImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -verticalAnchorConstant),
            
            userName.leadingAnchor.constraint(equalTo: diaryImage.trailingAnchor, constant: horizontalAnchorConstant),
            userName.topAnchor.constraint(equalTo: diaryImage.topAnchor),
            userName.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -horizontalAnchorConstant),
            
            date.leadingAnchor.constraint(equalTo: diaryImage.trailingAnchor, constant: horizontalAnchorConstant),
            date.firstBaselineAnchor.constraintEqualToSystemSpacingBelow(userName.lastBaselineAnchor, multiplier: 1),
            date.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -horizontalAnchorConstant),

            weatherImage.centerYAnchor.constraint(equalTo: date.centerYAnchor),

            chatButton.topAnchor.constraint(equalTo: date.topAnchor),
            chatButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalAnchorConstant),

            content.firstBaselineAnchor.constraintEqualToSystemSpacingBelow(date.lastBaselineAnchor, multiplier: 1),

            content.leadingAnchor.constraint(equalTo: diaryImage.trailingAnchor, constant: horizontalAnchorConstant),
            content.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -horizontalAnchorConstant),
            content.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -verticalAnchorConstant),
            
        ]
        
        largeConstraints = [
            userName.leadingAnchor.constraint(equalTo: diaryImage.leadingAnchor),
            userName.topAnchor.constraint(equalTo: diaryImage.bottomAnchor),
            userName.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -horizontalAnchorConstant),
            
            date.leadingAnchor.constraint(equalTo: diaryImage.leadingAnchor),
            date.firstBaselineAnchor.constraintEqualToSystemSpacingBelow(userName.lastBaselineAnchor, multiplier: 1),
            date.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -horizontalAnchorConstant),
            date.bottomAnchor.constraint(lessThanOrEqualTo: weatherImage.topAnchor, constant: -verticalAnchorConstant),

            weatherImage.leadingAnchor.constraint(equalTo: diaryImage.leadingAnchor),
            weatherImage.bottomAnchor.constraint(equalTo: chatButton.topAnchor, constant: -verticalAnchorConstant),

            
            chatButton.bottomAnchor.constraint(equalTo: content.topAnchor, constant: -verticalAnchorConstant),
            chatButton.leadingAnchor.constraint(equalTo: diaryImage.leadingAnchor),

            content.leadingAnchor.constraint(equalTo: diaryImage.leadingAnchor, constant: horizontalAnchorConstant),
            content.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -horizontalAnchorConstant),
            content.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -verticalAnchorConstant),
        ]
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
            updateLayoutContraints()
        }
    }
    
    private func updateLayoutContraints() {
        NSLayoutConstraint.activate(commonConstraints)
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(largeConstraints)
        } else {
            NSLayoutConstraint.deactivate(largeConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}



