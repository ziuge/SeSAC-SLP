//
//  MypageTableViewCell.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/15.
//

import UIKit

// MARK: ImageTableViewCell
class ImageTableViewCell: BaseTableViewCell {
    
    var image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sesac_img")
        return view
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure() {
        contentView.addSubview(image)
    }
    override func setConstraints() {
        image.snp.makeConstraints { make in
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
        return view
    }()
    let maleButton: UIButton = {
        let button = SeSACButton()
        button.titleText = "남자"
        return button
    }()
    let femaleButton: UIButton = {
        let button = SeSACButton()
        button.titleText = "여자"
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
            make.top.equalTo(contentView).offset()
        }
        femaleButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(48)
            make.width.equalTo(56)
        }
    }
    
}

// MARK: FrequentStudyTableViewCell
class FrequentStudyTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "자주 하는 스터디"
        return view
    }()
    let textField: UITextField = {
        let view = InputTextField()
        view.placeholder = "스터디를 입력해 주세요"
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
        }
    }
}

// MARK: AllowSearchTableViewCell
class AllowSearchTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "내 번호 검색 허용"
        return view
    }()
    let allowSwitch: UISwitch = {
        let view = UISwitch()
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
    }
}

// MARK: AgeRangeTableViewCell
class AgeRangeTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "상대방 연령대"
        return view
    }()
    let numberLabel: UILabel = {
        let view = UILabel()
        view.text = "18 - 35"
        return view
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure() {
        [label, numberLabel].forEach {
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

// MARK: SecessionTableViewCell
class SecessionTableViewCell: BaseTableViewCell {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "회원 탈퇴"
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
