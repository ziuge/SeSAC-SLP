//
//  MyChatTableViewCell.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/04.
//

import UIKit

class MyChatTableViewCell: BaseTableViewCell {
    
    var chatLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configure() {
        contentView.addSubview(chatLabel)
        
    }
    override func setConstraints() {
        chatLabel.snp.makeConstraints { make in
            
        }
    }
    
}
