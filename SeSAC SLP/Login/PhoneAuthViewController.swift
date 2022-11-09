//
//  PhoneAuthViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa

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
        button.isEnabled = true
        button.setColor(backgroundColor: Constants.Color.gray6, borderColor: .clear, textColor: Constants.Color.gray3, for: .disabled)
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
    
    let disposeBag = DisposeBag()
    let viewModel = PhoneAuthViewModel()
    
    var message = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
//        bind()
        
        button.addTarget(self, action: #selector(getNumber), for: .touchUpInside)
    }
    
    @objc func getNumber() {
        print(#function)
//        let phoneNumber = "+16995552312"
        let phoneNumber = textField.text!
//        let testVerificationCode = "312345"
//        Auth.auth().settings!.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
                if let error = error {
                    print("error", error.localizedDescription)
                    return
                }
                print("success")

                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")

                let vc = PhoneVerificationViewController()
                vc.verificationID = verificationID
                self?.navigationController?.pushViewController(vc, animated: true)
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
    
    func bind() {

        let input = PhoneAuthViewModel.Input(number: textField.rx.text, tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validation
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.tap
            .bind { [weak self] in
                print("Show toast")
                self?.showToast(message: " 잘못된 전화번호 형식입니다. ")
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
    
}

extension PhoneAuthViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return false
        }
        
        textField.text = text.withHyphen()
        
        let count = text.count
        if count > 11 || count < 9 {
            button.isEnabled = false
//            self.showToast(message: " 잘못된 전화번호 형식입니다. ")
            return false
        }
        return true
    }
}
