//
//  GenderViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/11.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class GenderViewController: BaseViewController {
    // MARK: UI
    var label: UILabel = {
        let view = UILabel()
        view.text = "성별을 선택해 주세요\n새싹 찾기 기능을 이용하기 위해서 필요해요!"
        view.textAlignment = .center
        view.font = Constants.Font.display1
        view.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Constants.Font.display1_lineHeight
        view.halfTextColorAndFontChange(fullText: view.text!, changeText: "새싹 찾기 기능을 이용하기 위해서 필요해요!", color: Constants.Color.gray7, font: Constants.Font.title2!)
        return view
    }()
    var maleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "man"), for: .normal)
        button.setTitle("남자", for: .normal)
        button.alignTextBelow()
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        button.setColor(backgroundColor: Constants.Color.white, borderColor: Constants.Color.gray3, textColor: Constants.Color.black, for: .normal)
        button.setColor(backgroundColor: Constants.Color.whiteGreen, borderColor: Constants.Color.whiteGreen, textColor: Constants.Color.black, for: .selected)
        return button
    }()
    var femaleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "woman"), for: .normal)
        button.setTitle("여자", for: .normal)
        button.alignTextBelow()
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        button.setColor(backgroundColor: Constants.Color.white, borderColor: Constants.Color.gray3, textColor: Constants.Color.black, for: .normal)
        button.setColor(backgroundColor: Constants.Color.whiteGreen, borderColor: Constants.Color.whiteGreen, textColor: Constants.Color.black, for: .selected)
        return button
    }()
    var buttonStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 12
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
        return view
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = NicknameValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        maleButton.isSelected = true
        femaleButton.isSelected = false
        
        button.addTarget(self, action: #selector(getEmail), for: .touchUpInside)
        maleButton.addTarget(self, action: #selector(toggleMaleButton), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(toggleFemaleButton), for: .touchUpInside)
    }

    func bind() {
    }
    
    @objc func getEmail() {
        print(#function)
    }

    override func configure() {
        view.addSubview(stack)
        [label, buttonStack, button].forEach {
            stack.addArrangedSubview($0)
        }
        view.addSubview(validationLabel)
        [maleButton, femaleButton].forEach {
            buttonStack.addArrangedSubview($0)
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
        
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        validationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(button.snp.bottom).offset(4)
        }
        buttonStack.snp.makeConstraints { make in
            
        }
        maleButton.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        femaleButton.snp.makeConstraints { make in
            make.height.equalTo(120)
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
    
    @objc func toggleMaleButton() {
        if maleButton.isSelected == false {
            maleButton.isSelected = true
            femaleButton.isSelected = false
        }
    }
    
    @objc func toggleFemaleButton() {
        if femaleButton.isSelected == false {
            maleButton.isSelected = false
            femaleButton.isSelected = true
        }
    }
    
}

