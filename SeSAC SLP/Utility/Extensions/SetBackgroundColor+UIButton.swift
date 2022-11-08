//
//  SetBackgroundColor+UIButton.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/08.
//

import UIKit

extension UIButton {
    func setColor(backgroundColor: UIColor, borderColor: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(backgroundColor.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
        self.layer.borderColor = borderColor.cgColor
    }
}
