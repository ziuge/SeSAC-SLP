//
//  BirthViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/11.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import FirebaseAuth

class BirthViewController: BaseViewController {
    // MARK: UI
    var label: UILabel = {
        let view = UILabel()
        view.text = "생년월일을 알려주세요"
        view.textAlignment = .center
        view.font = Constants.Font.display1
        view.numberOfLines = 2
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Constants.Font.display1_lineHeight
        return view
    }()
    var textField: InputTextField = {
        let view = InputTextField()
        view.placeholderText = "2022"
        return view
    }()
    let datePicker = UIDatePicker()
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
    
    var birthDate: Date = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    let disposeBag = DisposeBag()
    let viewModel = BirthValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bind()
        configureDatePicker()
        print(self, SignupDetails.details)
        if SignupDetails.details.birth != "" {
            textField.text = SignupDetails.details.birth
            // TODO: textField 3개로 수정하고나서 수정
        }
        
        button.addTarget(self, action: #selector(getBirth), for: .touchUpInside)
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
    
    @objc func getBirth() {
        print(#function)
        
        let registerableBirth = Calendar.current.date(byAdding: .year, value: -17, to: Date())!
        // TODO: if success/fail 분기처리
        if birthDate < registerableBirth {
            SignupDetails.details.birth = String(describing: birthDate)
            let vc = EmailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showValidationLabel()
        }
        
    }
    
    // DATE PICKER
    private func configureDatePicker(){
        self.datePicker.datePickerMode = .date // 날짜 만 나오게
        self.datePicker.preferredDatePickerStyle = .wheels // 그냥 데이터 피커가 아닌 프리페어 데이트 피커
        //ADDTarget UiColor 객체가 이벤트에 응답하게 설정을 해주는 메서드
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        //첫번째 파라미터 는 타겟을 설정
        //두번째 는 응답 할 메서드
        //세번째 for 파라미터는 어떤 일이 일어났을때 어떤 메서드를 호출 할 건지 정의 -> valueChanged 값이 변경될때 #selector 함수가 호출되게 하기
        self.datePicker.locale = Locale(identifier: "ko-KR")
        self.textField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter() // 데이트 타입을 사람이 읽을 수 있도록 사람이 변환을 해주거나, 날짜 타입에서 데이트 타입을 변환을시켜주는 역할
        formmater.dateFormat = "yyyy 년 MM 월 dd 일(EEEEE)" //데이트 포멧형식 잡기
        formmater.locale = Locale(identifier: "ko_KR") // 한국어 표현
        self.birthDate = datePicker.date // datePicker 에서 선택된 date값 넘기기
        self.textField.text = formmater.string(from: datePicker.date) // 포멧한 데이트 값을 텍스트 필드에 표시
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
