//
//  OnboardingPageViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/07.
//

import UIKit
import SnapKit

class OnboardingPageViewController: BaseViewController {
    
    // MARK: UI
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    var startButton: H48FillButton = {
        var button = H48FillButton()
        button.titleText = "시작하기"
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.white
        addPageVC()
        
        startButton.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
    }
    
    override func configure() {
        [containerView, startButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.bottomMargin.equalTo(view).offset(-120)
        }

        startButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
            make.bottom.equalTo(view).offset(-60)
        }
    }
    
    @objc func gotoLogin() {
        let vc = PhoneAuthViewController()
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    func addPageVC() {
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        setPageConstraints()
    }
    
    func setPageConstraints() {
        vc.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(containerView)
        }
    }
    
}

