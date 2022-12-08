//
//  YourChatTableViewCell.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/04.
//

import UIKit

class YourChatTableViewCell: BaseTableViewCell {
    
    var chatLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        contentView.addSubview(chatLabel)
        
    }
    override func setConstraints() {
        chatLabel.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(contentView)
        }
    }
    
}

