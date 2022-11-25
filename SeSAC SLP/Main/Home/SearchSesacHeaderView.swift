//
//  SearchSesacHeaderView.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/25.
//

import UIKit

class CategoryHeaderView: UICollectionReusableView {
    
    let label: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.title6
        view.text = "지금 주변에는"
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: nil)
    }
    
    func prepare(text: String?) {
        self.label.text = text
      }
}
