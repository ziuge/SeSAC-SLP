//
//  TextColorChange+UILabel.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

extension UILabel {
    func halfTextColorChange (fullText: String, changeText: String, color: UIColor) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = attribute
    }
    
    func halfTextColorAndFontChange(fullText: String, changeText: String, color: UIColor, font: UIFont) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(.font, value: font, range: range)
        attribute.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attribute
    }
}
