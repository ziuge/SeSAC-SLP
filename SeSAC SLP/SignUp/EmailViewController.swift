//
//  EmailViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/11.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class EmailViewController: BaseViewController {
    // MARK: UI
    var label: UILabel = {
        let view = UILabel()
        view.text = "이메일을 입력해 주세요\n휴대폰 번호 변경 시 인증을 위해 사용해요"
        view.textAlignment = .center
        view.font = Constants.Font.display1
        view.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Constants.Font.display1_lineHeight
        view.halfTextColorAndFontChange(fullText: view.text!, changeText: "휴대폰 번호 변경 시 인증을 위해 사용해요", color: Constants.Color.gray7, font: Constants.Font.title2!)
        return view
    }()
    var textField: InputTextField = {
        let view = InputTextField()
        view.placeholderText = "SeSAC@email.com"
        view.keyboardType = .default
        view.becomeFirstResponder()
        return view
    }()
    var button: SeSACButton = {
        let button = SeSACButton()
        button.titleText = "다음"
        button.isEnabled = true
        button.setColor(backgroundColor: Constants.Color.gray6, borderColor: .clear, textColor: Constants.Color.gray3, for: .normal)
        return button
    }()
    let stack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        return view
    }()
    var validationLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.Color.gray3
        view.layer.cornerRadius = 8.0
        view.textColor = Constants.Color.white
        view.font = Constants.Font.body3
        view.isHidden = true
        view.text = "잘못된 이메일"
        return view
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = NicknameValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if SignupDetails.details.email != "" {
            textField.text = SignupDetails.details.email
        }
        
        button.addTarget(self, action: #selector(getEmail), for: .touchUpInside)
    }
    
    override func configure() {
        view.addSubview(stack)
        [label, textField, button].forEach {
            stack.addArrangedSubview($0)
        }
        view.addSubview(validationLabel)
    }
    override func setConstraints() {
        let spacing = 16
        let frameHeight = view.frame.height
        
        stack.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            
            make.leading.equalTo(view).offset(spacing)
            make.trailing.equalTo(view).offset(-spacing)
            make.bottom.equalTo(view).offset((-frameHeight / 2) + 40)
            make.height.equalTo(view).multipliedBy(0.35)
        }
        
        label.snp.makeConstraints { make in
            
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        validationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(button.snp.bottom).offset(4)
        }
    }
    
    @objc func getEmail() {
        print(#function)
        
        if isValidEmail(testStr: textField.text ?? "") {
            SignupDetails.details.email = textField.text!
            let vc = GenderViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showValidationLabel()
        }
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func showValidationLabel() {
        print(#function)
        self.validationLabel.isHidden = false
        UIView.animate(withDuration: 3.0, delay: 0.2, options: .curveEaseOut, animations: {
            self.validationLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            self.validationLabel.isHidden = true
            self.validationLabel.alpha = 1.0
        })
    }
    
}
