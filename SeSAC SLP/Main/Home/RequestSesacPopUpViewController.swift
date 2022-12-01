//
//  RequestSesacPopUpViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/29.
//

import UIKit

class RequestSesacPopUpViewController: BaseViewController {
    
    let popupView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = Constants.Color.white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.black.withAlphaComponent(0.5)
    }
    
    override func configure() {
        [popupView].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        popupView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.height.equalTo(178)
        }
    }
}
