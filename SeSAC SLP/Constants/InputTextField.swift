//
//  InputTextField.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

@IBDesignable
final class InputTextField: UITextField {

//    var borderWidth: CGFloat = 2.0
//    var borderColor = Constants.Color.black

    @IBInspectable var placeholderText: String? {
        didSet {
            self.placeholder = placeholderText
//            self.borderStyle = .line
            self.font = Constants.Font.title4
        }
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    func setup() {
        self.clipsToBounds = true
//        self.layer.cornerRadius = 8.0
//        self.layer.borderColor = borderColor.cgColor
//        self.layer.borderWidth = borderWidth
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = Constants.Color.gray3.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}
