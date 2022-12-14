//
//  ChatTableCustomHeaderView.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/13.
//

import UIKit

class ChatTableCustomHeaderView: BaseTableViewHeaderView {
    
    private var dateLabel: UILabel = {
        let view = UILabel()
        view.layer.backgroundColor = Constants.Color.gray7.cgColor
        view.layer.cornerRadius = 20
        view.text = "yymmdd"
        view.textColor = Constants.Color.white
        view.font = Constants.Font.title5
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configure() {
        contentView.addSubview(dateLabel)
    }
    override func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.height.equalTo(28)
            make.width.equalTo(114)
        }
    }
}
