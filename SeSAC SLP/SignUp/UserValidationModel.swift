//
//  UserValidationModel.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/10.
//

import Foundation
import RxSwift

class UserValidationModel {
    
    let user = PublishSubject<User>()
    
    func getUser() {
        let api = SeSACAPI.signup(userName: "최지원", email: "jiwon@naver.com", password: "1234abcd")
        Network.shared.requestSeSAC(type: User.self, url: api.url, headers: api.headers) { [weak self] response in
            switch response {
            case .success(let success):
                self?.user.onNext(success)
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
}
