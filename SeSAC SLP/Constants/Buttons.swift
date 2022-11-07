//
//  Buttons.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

@IBDesignable
final class H48FillButton: UIButton {

    var borderWidth: CGFloat = 2.0
    var borderColor = Constants.Color.green
    var background = Constants.Color.green

    @IBInspectable var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
            self.setTitleColor(Constants.Color.white, for: .normal)
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
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.backgroundColor = background
    }
}

