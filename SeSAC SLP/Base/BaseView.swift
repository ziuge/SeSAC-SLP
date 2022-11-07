//
//  BaseView.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() { }
    func setConstraints() { }
}

