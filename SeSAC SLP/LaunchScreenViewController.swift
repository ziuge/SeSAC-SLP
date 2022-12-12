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
        getToken()
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
            print("NetworkMonitor connected")
            
//            if UserDefaults.standard.string(forKey: "idToken") == nil {
//                getToken()
//            }

            let api = SeSACAPI.login
            Network.shared.requestSeSAC(type: UserInfo.self, url: api.url, method: .get, parameters: api.parameters, headers: api.headers) { response in
                switch response {
                case .success(let userinfo):
                    print("==== login success", UserDefaults.standard.string(forKey: "idToken"))
                    print(userinfo)

                    let info = UserInfo(id: userinfo.id, reputation: userinfo.reputation, comment: userinfo.comment, sesacCollection: userinfo.sesacCollection, backgroundCollection: userinfo.backgroundCollection, purchaseToken: userinfo.purchaseToken, transactionID: userinfo.transactionID, reviewedBefore: userinfo.reviewedBefore, reportedUser: userinfo.reportedUser, uid: userinfo.uid, phoneNumber: userinfo.phoneNumber, fcMtoken: userinfo.fcMtoken, nick: userinfo.nick, birth: userinfo.birth, email: userinfo.email, gender: userinfo.gender, sesac: userinfo.sesac, study: userinfo.study, dodgepenalty: userinfo.dodgepenalty, background: userinfo.background, ageMin: userinfo.ageMin, ageMax: userinfo.ageMax, dodgeNum: userinfo.dodgeNum, searchable: userinfo.searchable, reportedNum: userinfo.reportedNum, createdAt: userinfo.createdAt, v: userinfo.v)
                    
                    let encoder = JSONEncoder()

                    /// encoded는 Data형
                    if let encoded = try? encoder.encode(info) {
                        UserDefaults.standard.setValue(encoded, forKey: "userinfo")
                    }
                    
                    if let savedData = UserDefaults.standard.object(forKey: "userinfo") as? Data {
                        let decoder = JSONDecoder()
                        if let savedObject = try? decoder.decode(UserInfo.self, from: savedData) {
                            print(savedObject) // Person(name: "jake", age: 20)
                        }
                    }
                    
                    print("using Manager~~", UserDefaultsManager.userinfo)
                    
                case .failure(let error):
                    print("==== login error", error)
                }
            }
            
            let vc = MainViewController()
//            let vc = OnboardingPageViewController()
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            
        } else {
            showToast(message: "네트워크에 연결해주세요")
        }
    }
    
    func getToken() {
        print(#function)
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("error", error)
                return;
            }
            print("idToken:", idToken)
            UserDefaults.standard.set(idToken, forKey: "idToken")
            print("== UserDefaults idToken", UserDefaults.standard.string(forKey: "idToken"))
        }
    }
    
}
