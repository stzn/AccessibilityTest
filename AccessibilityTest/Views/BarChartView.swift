//
//  BarChartView.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/07/19.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

protocol BarEntry {
    var color: UIColor { get }
    var height: Float { get }
    var text: String { get }
    var title: String { get }
}

final class BarChartView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    let barWidth: CGFloat = 40.0
    let space: CGFloat = 20.0
    
    private let bottomSpace: CGFloat = 40.0
    private let topSpace: CGFloat = 40.0
    
    private let mainLayer: CALayer = CALayer()
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private var elements: [UIAccessibilityElement] = []
    
    var entries: [BarEntry]? = nil {
        didSet {
            mainLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
            
            if let entries = entries {
                scrollView.contentSize = CGSize(width: (barWidth + space) * CGFloat(entries.count), height: self.frame.size.height)
                mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
                
                drawHorizontalLines()
                
                entries.enumerated().forEach { (i, entry) in
                    show(index: i, entry: entry)
                }
                
                self.accessibilityElements = elements
            }
        }
    }
    
    private func show(index: Int, entry: BarEntry) {
        
        let x: CGFloat = space + CGFloat(index) * (barWidth + space)
        let y: CGFloat = translateHeightValueToY(value: entry.height)
        
        drawBar(x: x, y: y, color: entry.color)
        
        drawText(x: x - space / 2, y: y - 30, text: entry.text, color: entry.color)
        
        drawTitle(x: x - space / 2, y: mainLayer.frame.height - bottomSpace + 10, title: entry.title, color: entry.color)
        
        setAccessibility(x: x, y: y - 30, title: entry.title, text: entry.text)
    }
    
    private func drawBar(x: CGFloat, y: CGFloat, color: UIColor) {
        
        let barLayer = CALayer()
        barLayer.frame = CGRect(x: x, y: y, width: barWidth, height: mainLayer.frame.height - bottomSpace - y)
        
        barLayer.backgroundColor = color.cgColor
        mainLayer.addSublayer(barLayer)
    }

    private func drawHorizontalLines() {

        struct LineInfo {
            let value: Float
            let dashed: Bool
        }
        
        self.layer.sublayers?.forEach {
            if $0 is CAShapeLayer {
                $0.removeFromSuperlayer()
            }
        }
        
        let horizontalLineInfos = [LineInfo(value: 0.0, dashed: false), LineInfo(value: 0.5, dashed: true), LineInfo(value: 1.0, dashed: false)]
        for lineInfo in horizontalLineInfos {
            let x = CGFloat(0.0)
            let y = translateHeightValueToY(value: lineInfo.value)
            let path = UIBezierPath()
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: scrollView.frame.size.width, y: y))
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.lineWidth = 0.5
            if lineInfo.dashed {
                lineLayer.lineDashPattern = [4, 4]
            }
            lineLayer.strokeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            self.layer.insertSublayer(lineLayer, at: 0)
        }
    }

    private func drawText(x: CGFloat, y: CGFloat, text: String, color: UIColor) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: x, y: y, width: barWidth + space, height: 22)
        textLayer.foregroundColor = color.cgColor
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = 14
        textLayer.string = text
        mainLayer.addSublayer(textLayer)
    }

    private func drawTitle(x: CGFloat, y: CGFloat, title: String, color: UIColor) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: x, y: y, width: barWidth + space, height: 22)
        textLayer.foregroundColor = color.cgColor
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = 14
        textLayer.string = title
        mainLayer.addSublayer(textLayer)
    }

    private func setAccessibility(x: CGFloat, y: CGFloat, title: String, text: String) {
        let frame =  CGRect(x: x, y: y, width: barWidth, height: bounds.height - y)
        let element = UIAccessibilityElement(accessibilityContainer: self)
        element.accessibilityLabel = title
        element.accessibilityValue = text
        element.accessibilityFrameInContainerSpace = frame
        
        elements.append(element)
    }
    
    private func translateHeightValueToY(value: Float) -> CGFloat {
        let height: CGFloat = CGFloat(value) * (mainLayer.frame.height - bottomSpace - topSpace)
        return mainLayer.frame.height - bottomSpace - height
    }
}
