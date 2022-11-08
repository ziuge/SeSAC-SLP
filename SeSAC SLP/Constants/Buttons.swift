//
//  Buttons.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

@IBDesignable
final class SeSACButton: UIButton {

    var borderWidth: CGFloat = 2.0
    var borderColor = Constants.Color.green
    var background = Constants.Color.green
    var text = Constants.Color.white

    @IBInspectable var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
            self.setTitleColor(Constants.Color.white, for: .normal)
        }
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.backgroundColor = background
        self.setColor(backgroundColor: background, borderColor: .clear, textColor: text, for: .normal)
        self.setColor(backgroundColor: Constants.Color.gray6, borderColor: .clear, textColor: Constants.Color.gray3, for: .disabled)
    }
}

