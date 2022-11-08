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
    var button: SeSACButton = {
        let button = SeSACButton()
        button.titleText = "인증 문자 받기"
        button.isEnabled = false
        button.setColor(backgroundColor: Constants.Color.gray6, borderColor: Constants.Color.gray6, textColor: Constants.Color.gray3, for: .disabled)
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
        
        textField.delegate = self
        button.addTarget(self, action: #selector(getNumber), for: .touchUpInside)
    }
    
    @objc func getNumber() {
        print(#function)
//        let phoneNumber = "+1 699-555-2312"
        let phoneNumber = textField.text!
        let testVerificationCode = "982398"
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

extension PhoneAuthViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return false
        }
        let count = text.count
        var updatedText = text.replacingCharacters(in: textRange, with: string)
        updatedText.removeAll(where: {$0 == "-"})
        if string != "" {
            if count > 12
            {
                button.isEnabled = false
                // TODO: Toast 유효한 전화번호 입력
                return false
            }
            if count == 3 || count == 7 {
                textField.text! += "-"
            }
            if count == 12 {
//                textField.text?.removeAll(where: {$0 == "-"})
                updatedText.removeAll(where: {$0 == "-"})
                var index = updatedText.index(updatedText.startIndex, offsetBy: 3)
                updatedText.insert("-", at: index)
                index = updatedText.index(updatedText.startIndex, offsetBy: 8)
                updatedText.insert("-", at: index)
                textField.text = updatedText
            }
            return true
        }
        return true
    }
}
