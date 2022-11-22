//
//  MypageTableViewCell.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/15.
//

import UIKit
import MultiSlider

// MARK: ImageTableViewCell
class ImageTableViewCell: BaseTableViewCell {
    
    var background: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sesac_background_\(LoginDetails.details.background + 1)")
        return view
    }()
    
    var sesacImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sesac_face_\(LoginDetails.details.sesac + 1)")
        return view
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure() {
        contentView.addSubview(background)
        contentView.addSubview(sesacImage)
    }
    override func setConstraints() {
        background.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(190)
        }
    }
    
}

// MARK: GenderTableViewCell
class GenderTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "내 성별"
        view.font = Constants.Font.title4
        return view
    }()
    let maleButton: UIButton = {
        let button = SeSACButton()
        button.titleText = "남자"
        button.titleLabel?.font = Constants.Font.body3
        return button
    }()
    let femaleButton: UIButton = {
        let button = SeSACButton()
        button.titleText = "여자"
        button.titleLabel?.font = Constants.Font.body3
        return button
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func configure() {
        [label, maleButton, femaleButton].forEach {
            contentView.addSubview($0)
        }
    }
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
        }
        maleButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(femaleButton.snp.leading).offset(-8)
            make.height.equalTo(48)
            make.width.equalTo(56)
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
        }
        femaleButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(48)
            make.width.equalTo(56)
        }
        if LoginDetails.details.gender == 0 {
            femaleButton.setColor(backgroundColor: Constants.Color.green, borderColor: .clear, textColor: Constants.Color.white, for: .normal)
            maleButton.setColor(backgroundColor: Constants.Color.white, borderColor: Constants.Color.gray3, textColor: Constants.Color.gray3, for: .normal)
        } else {
            maleButton.setColor(backgroundColor: Constants.Color.green, borderColor: .clear, textColor: Constants.Color.white, for: .normal)
            femaleButton.setColor(backgroundColor: Constants.Color.white, borderColor: Constants.Color.gray3, textColor: Constants.Color.gray3, for: .normal)
        }
    }
    
}

// MARK: FrequentStudyTableViewCell
class FrequentStudyTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "자주 하는 스터디"
        view.font = Constants.Font.title4
        return view
    }()
    let textField: UITextField = {
        let view = InputTextField()
        view.placeholder = "스터디를 입력해 주세요"
        view.font = Constants.Font.title4
        return view
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure() {
        [label, textField].forEach {
            contentView.addSubview($0)
        }
    }
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
        }
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.height.equalTo(48)
        }
    }
}

// MARK: AllowSearchTableViewCell
class AllowSearchTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "내 번호 검색 허용"
        view.font = Constants.Font.title4
        return view
    }()
    let allowSwitch: UISwitch = {
        let view = UISwitch()
        view.isSelected = true
        return view
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure() {
        [label, allowSwitch].forEach {
            contentView.addSubview($0)
        }
    }
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
        }
        allowSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.trailing.equalTo(contentView).offset(-16)
        }
        if LoginDetails.details.searchable == 0 {
            allowSwitch.isOn = false
        } else {
            allowSwitch.isOn = true
        }
    }
}

// MARK: AgeRangeTableViewCell
class AgeRangeTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "상대방 연령대"
        view.font = Constants.Font.title4
        return view
    }()
    let numberLabel: UILabel = {
        let view = UILabel()
        view.text = "\(LoginDetails.details.ageMin) - \(LoginDetails.details.ageMax)"
        view.font = Constants.Font.title3
        view.textColor = Constants.Color.green
        return view
    }()
    let ageSlider: MultiSlider = {
        let view = MultiSlider()
        view.minimumValue = 18
        view.maximumValue = 65
        view.thumbTintColor = Constants.Color.green
        view.value = [18, 35, 65]
        view.snapStepSize = 1.0
        view.trackWidth = 120
        view.isVertical = true
        view.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
//        view.outerTrackColor = .lightGray
        return view
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func configure() {
        [label, numberLabel, ageSlider].forEach {
            contentView.addSubview($0)
        }
    }
    override func setConstraints() {
        label.snp.makeConstraints { make in
//            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(8)
        }
        numberLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(8)
        }
        ageSlider.snp.makeConstraints { make in
//            make.leading.equalTo(contentView).offset(16)
//            make.trailing.equalTo(contentView).offset(-16)
            make.centerX.equalTo(contentView)
            make.top.equalTo(label.snp.bottom).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
        }
        
    }
    
    @objc func sliderChanged() {
        print("thumb \(ageSlider.draggedThumbIndex) moved")
        print("now thumbs are at \(ageSlider.value)")
    }
}

// MARK: SecessionTableViewCell
class SecessionTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "회원 탈퇴"
        view.font = Constants.Font.title4
        return view
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure() {
        [label].forEach {
            contentView.addSubview($0)
        }
    }
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
        }
    }
}
