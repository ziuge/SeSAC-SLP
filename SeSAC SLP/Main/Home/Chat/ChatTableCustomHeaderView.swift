//
//  ChatTableCustomHeaderView.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/13.
//

import UIKit

class ChatTableCustomHeaderView: BaseTableViewHeaderView {
    
    // MARK: UI
    private var dateLabel: UILabel = {
        let view = UILabel()
        view.layer.backgroundColor = Constants.Color.gray7.cgColor
        view.layer.cornerRadius = 14
        view.text = "00월 00일 월요일"
        view.textColor = Constants.Color.white
        view.font = Constants.Font.title5
        view.textAlignment = .center
        return view
    }()
    
    // MARK: init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .brown
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
            make.centerY.equalTo(contentView)
            make.height.equalTo(28)
            make.width.equalTo(114)
        }
    }
}
