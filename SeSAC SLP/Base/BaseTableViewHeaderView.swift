//
//  BaseTableViewHeaderView.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/13.
//

import UIKit

class BaseTableViewHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "UITableViewHeaderFooterView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {}
    func setConstraints() {}
}
