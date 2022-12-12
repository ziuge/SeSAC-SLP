//
//  EmptyBackground+UITableView.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/12.
//

import Foundation
import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String, submessage: String) {
        let emptyImage: UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "empty")
            return img
        }()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textAlignment = .center;
            label.font = Constants.Font.display1
            label.textColor = Constants.Color.black
            label.sizeToFit()
            return label
        }()
        let bodyLabel: UILabel = {
            let label = UILabel()
            label.text = submessage
            label.font = Constants.Font.title4
            label.textColor = Constants.Color.gray7
            return label
        }()
        
        self.backgroundView = UIView()
        
        [emptyImage, titleLabel, bodyLabel].forEach {
            self.backgroundView?.addSubview($0)
        }
        
        emptyImage.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.centerX.equalTo(self.backgroundView!)
            make.centerY.equalTo(self.backgroundView!).offset(-80)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.backgroundView!)
            make.top.equalTo(emptyImage.snp.bottom).offset(32)
        }
        bodyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.backgroundView!)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
