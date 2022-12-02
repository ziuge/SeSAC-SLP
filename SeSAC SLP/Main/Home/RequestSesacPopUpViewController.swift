//
//  RequestSesacPopUpViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/29.
//

import UIKit

class RequestSesacPopUpViewController: BaseViewController {
    
    var otheruid: String = ""
    
    let popupView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = Constants.Color.white
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디를 요청할게요!"
        label.textAlignment = .center
        label.textColor = Constants.Color.black
        label.font = Constants.Font.body1
        return label
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "상대방이 요청을 수락하면\n채팅창에서 대화를 나눌 수 있어요"
        label.textAlignment = .center
        label.textColor = Constants.Color.gray7
        label.font = Constants.Font.title4
        label.numberOfLines = 2
        return label
    }()
    let cancelButton: SeSACButton = {
        let view = SeSACButton()
        view.setColor(backgroundColor: Constants.Color.gray2, borderColor: .clear, textColor: Constants.Color.black, for: .normal)
        view.setTitle("취소", for: .normal)
        view.titleLabel?.font = Constants.Font.body3
        return view
    }()
    let okButton: SeSACButton = {
        let view = SeSACButton()
        view.setColor(backgroundColor: Constants.Color.green, borderColor: .clear, textColor: Constants.Color.white, for: .normal)
        view.setTitle("확인", for: .normal)
        view.titleLabel?.font = Constants.Font.body3
        return view
    }()
    let stack: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.gray4.withAlphaComponent(0.3)
        
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    override func configure() {
        [popupView, titleLabel, bodyLabel, stack].forEach {
            view.addSubview($0)
        }
        [cancelButton, okButton].forEach {
            stack.addArrangedSubview($0)
        }
    }
    override func setConstraints() {
        popupView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.height.equalTo(178)
            make.centerY.equalTo(view)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(popupView).offset(16)
            make.trailing.equalTo(popupView).offset(-16)
            make.height.equalTo(30)
        }
        bodyLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        stack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.bottom.equalTo(popupView).offset(-16)
        }
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        okButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    @objc func cancelButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc func okButtonClicked() {
        print("okbuttonclicekd")
        print(otheruid)
        
        let api = SeSACAPI.studyrequest(otheruid: otheruid)
        Network.shared.requestSeSAC(type: Main.self, url: api.url, method: .post, parameters: api.parameters, headers: api.headers) { response in
            switch response {
            case .success(let success):
                print("requestSuccess")
                
            case .failure(let failure):
                print("request fail", failure)
            }
        }
    }
    
    
}
