//
//  PhoneAuthViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit
import FirebaseAuth

class PhoneAuthViewController: BaseViewController {
    
    // MARK: UI
    var label: UILabel = {
        let view = UILabel()
        view.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        view.textAlignment = .center
        view.font = Constants.Font.display1
        view.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Constants.Font.display1_lineHeight
        return view
    }()
    var textField: InputTextField = {
        let view = InputTextField()
        view.placeholderText = "휴대폰 번호(-없이 숫자만 입력)"
        view.keyboardType = .phonePad
        view.becomeFirstResponder()
        return view
    }()
    var button: H48FillButton = {
        let button = H48FillButton()
        button.titleText = "인증 문자 받기"
        button.setTitle("선택", for: .selected)
        return button
    }()
    let stack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
//        view.spacing = 72
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.white
        
        button.addTarget(self, action: #selector(getNumber), for: .touchUpInside)
    }
    
    @objc func getNumber() {
        print(#function)
//        let phoneNumber = "+1 699-555-2312"
        let phoneNumber = textField.text!
        let testVerificationCode = "312345"
        Auth.auth().settings!.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("error", error.localizedDescription)
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID ?? "",
              verificationCode: testVerificationCode
            )
                
            Auth.auth().signIn(with: credential) { (authData, error) in
                if (error != nil) {
                    print("로그인Error: \(error.debugDescription)")
                    return
                }
                print("authData: \(String(describing: authData))")
            }
        }
    }
    
    override func configure() {
        view.addSubview(stack)
        [label, textField, button].forEach {
            stack.addArrangedSubview($0)
        }
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
    }
    
}
