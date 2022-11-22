//
//  LaunchScreenViewController.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/17.
//

import Foundation
import UIKit
import FirebaseAuth

class LaunchScreenViewController: BaseViewController {
    
    // MARK: UI
    var image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "splash_logo")
        return view
    }()
    var logo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "splash_text")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetwork()
        
    }
    
    override func configure() {
        [image, logo].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        image.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-60)
            make.width.equalTo(view).multipliedBy(0.559796)
            make.height.equalTo(264)
        }
        logo.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(image.snp.bottom).offset(28)
            make.width.equalTo(image.snp.width).multipliedBy(1.18182)
            make.height.equalTo(101)
        }
    }
    
    func checkNetwork() {
        if NetworkMonitor.shared.isConnected {
            print("connected")
            
            getToken()
//            let vc = OnboardingPageViewController()
//
//            let scenes = UIApplication.shared.connectedScenes
//            let windowScene = scenes.first as? UIWindowScene
//            let window = windowScene?.windows.first
//            window?.rootViewController = UINavigationController(rootViewController: vc)
//            window?.makeKeyAndVisible()
            
        } else {
            showToast(message: "네트워크에 연결해주세요")
        }
    }
    
    func getToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                return;
            }
            print("idToken:", idToken)
        
            UserDefaults.standard.set(idToken, forKey: "idToken")
            print("== UserDefaults idToken", UserDefaults.standard.string(forKey: "idToken"))
        }
        let vc = MainViewController()
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
}
