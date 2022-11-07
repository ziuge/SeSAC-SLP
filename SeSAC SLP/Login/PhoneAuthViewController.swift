//
//  PhoneAuthViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit

class PhoneAuthViewController: BaseViewController {
    
    // MARK: UI
    var label: UILabel = {
        let view = UILabel()
        view.text = "새싹 서비스 이용을 위해 휴대폰 번호를 입력해 주세요"
        view.textAlignment = .center
        view.font = Constants.Font.display1
        view.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Constants.Font.display1_lineHeight
        return view
    }()
    var textField: InputTextField = {
        let view = InputTextField()
        return view
    }()
    var button: H48FillButton = {
        let button = H48FillButton()
        return button
    }()
    let stack: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        view.addSubview(stack)
        [label, textField, button].forEach {
            stack.addSubview($0)
        }
    }
    
    override func setConstraints() {
        stack.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            
        }
        
        label.snp.makeConstraints { make in
        }
    }
    
}
