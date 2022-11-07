//
//  ThirdViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

class ThirdViewController: BaseViewController {
    
    // MARK: UI
    var label: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.onboarding
        view.textAlignment = .center
        view.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        view.attributedText = NSMutableAttributedString(string: "SeSAC Study", attributes: [NSAttributedString.Key.kern: -0.5, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    var image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onboarding_img3")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        [label, image].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(image.snp.top).offset(-40)
        }
        
        image.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-60)
            make.width.height.equalTo(360)
        }
    }
}
