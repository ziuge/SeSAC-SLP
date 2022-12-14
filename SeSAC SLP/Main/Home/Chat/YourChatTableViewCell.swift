//
//  YourChatTableViewCell.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/04.
//

import UIKit

class YourChatTableViewCell: BaseTableViewCell {
    
    var chatLabel: BasePaddingLabel = {
        let view = BasePaddingLabel()
        view.layer.borderColor = Constants.Color.gray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.font = Constants.Font.body3
        return view
    }()
    var timeLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.title6
        view.textColor = Constants.Color.gray6
        view.text = "dd:dd"
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [chatLabel, timeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    override func setConstraints() {
        chatLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.bottom.equalTo(contentView).offset(-12)
            make.width.equalTo(contentView).multipliedBy(0.7)
            make.leading.equalTo(contentView).offset(16)
        }
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(chatLabel.snp.trailing).offset(8)
            make.bottom.equalTo(chatLabel.snp.bottom)
        }
    }
}

