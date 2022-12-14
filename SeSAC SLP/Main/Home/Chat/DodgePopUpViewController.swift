//
//  DodgePopUpViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/14.
//

import UIKit
import Alamofire

class DodgePopUpViewController: BaseViewController {
    
    var otheruid: String = ""
    
    let popupView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = Constants.Color.white
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디를 취소하시겠습니까?"
        label.textAlignment = .center
        label.textColor = Constants.Color.black
        label.font = Constants.Font.body1
        return label
    }()
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디를 취소하시면 패널티가 부과됩니다"
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
        print(#function, otheruid)
        dodgeStudy(otheruid: otheruid)
    }
    
    func dodgeStudy(otheruid: String) {
        print(#function, otheruid)
        let api = SeSACAPI.studydodge(otheruid: otheruid)
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { [weak self] response in
            switch response.result {
            case .success(_):
                guard let statuscode = response.response?.statusCode else { return }
                
                print(statuscode)
                
                self?.presentingViewController?.dismiss(animated: true)
            case .failure(_):
                guard let statuscode = response.response?.statusCode else { return }
                
                print(statuscode)
                self?.dismiss(animated: true)
            }
        }
    }
}
