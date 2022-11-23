//
//  PhoneVerificationViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/09.
//

import UIKit
import FirebaseAuth

class PhoneVerificationViewController: BaseViewController {
    // MARK: UI
    var label: UILabel = {
        let view = UILabel()
        view.text = "인증번호가 문자로 전송되었어요"
        view.textAlignment = .center
        view.font = Constants.Font.display1
        view.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Constants.Font.display1_lineHeight
        return view
    }()
    var textField: InputTextField = {
        let view = InputTextField()
        view.placeholderText = "인증번호 입력"
        view.keyboardType = .phonePad
        view.becomeFirstResponder()
        return view
    }()
    var button: SeSACButton = {
        let button = SeSACButton()
        button.titleText = "인증하고 시작하기"
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
    
    var verificationID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(getVerifyID), for: .touchUpInside)
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
    
    @objc func getVerifyID() {
        print(#function)
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ?? "",
            verificationCode: textField.text ?? ""
        )
            
        Auth.auth().signIn(with: credential) { [weak self] (authData, error) in
            if (error != nil) {
                print("로그인Error: \(error.debugDescription)")
                
                return
            }
            print("authData: \(String(describing: authData))")
            print("auth login Success")
            
//            if UserDefaults.standard.string(forKey: "idToken")?.isEmpty == nil {
                self?.getToken()
                let api = SeSACAPI.login
                Network.shared.requestSeSAC(type: User.self, url: api.url, headers: api.headers) { response in
                    switch response {
                    case .success(let success):
                        print("login Success", success)
                        
                        let vc = MainViewController()
                        let scenes = UIApplication.shared.connectedScenes
                        let windowScene = scenes.first as? UIWindowScene
                        let window = windowScene?.windows.first
                        window?.rootViewController = UINavigationController(rootViewController: vc)
                        window?.makeKeyAndVisible()
                    case .failure(let failure):
                        print("login fail, go sign up", failure)
                        let vc = NicknameViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
//            } else {
//
//            }
            
            // TODO: 회원일 경우와 아닐 경우 나누어서 연결하기
//            let vc = NicknameViewController()
//            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print(error)
                return;
            }
            print("idToken:", "\(idToken)")
        
            UserDefaults.setValue(idToken, forKey: "idToken")
            print("== UserDefaults idToken", UserDefaults.standard.string(forKey: "idToken"))
        }
    }
}
