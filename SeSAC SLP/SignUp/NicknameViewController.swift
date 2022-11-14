//
//  NicknameViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/10.
//

import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa

class NicknameViewController: BaseViewController {
    // MARK: UI
    var label: UILabel = {
        let view = UILabel()
        view.text = "닉네임을 입력해 주세요"
        view.textAlignment = .center
        view.font = Constants.Font.display1
        view.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Constants.Font.display1_lineHeight
        return view
    }()
    var textField: InputTextField = {
        let view = InputTextField()
        view.placeholderText = "10자 이내로 입력"
        view.keyboardType = .default
        view.becomeFirstResponder()
        return view
    }()
    var button: SeSACButton = {
        let button = SeSACButton()
        button.titleText = "다음"
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
    var validationLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.Color.gray3
        view.layer.cornerRadius = 8.0
        view.textColor = Constants.Color.white
        view.font = Constants.Font.body3
        view.isHidden = true
        return view
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = NicknameValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        getToken()
        
        print(self, SignupDetails.details)
        if SignupDetails.details.nick != "" {
            textField.text = SignupDetails.details.nick
        }
        
        button.addTarget(self, action: #selector(makeNickname), for: .touchUpInside)
    }
    
    func getToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            // Handle error
            return;
          }
          print("idToken:", idToken)
        }
    }
    
    func bind() {
        let input = NicknameValidationModel.Input(nick: textField.rx.text, tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.text
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.validation
            .withUnretained(self)
            .bind { (vc, value) in
                let color: [UIColor] = value ? [Constants.Color.green, Constants.Color.white] : [Constants.Color.gray6, Constants.Color.gray3]
                vc.button.setColor(backgroundColor: color[0], borderColor: .clear, textColor: color[1], for: .normal)
            }
            .disposed(by: disposeBag)
        
        output.tap
            .bind { _ in
                self.showValidationLabel()
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc func makeNickname() {
        print(#function)
        
        SignupDetails.details.nick = textField.text!
        
        let vc = BirthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
