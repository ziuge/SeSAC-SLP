//
//  SignupViewModel.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/14.
//

import Foundation
import RxSwift

class SignupViewModel {
//    static let shared = SignupViewModel()
//
//    private init() { }
//
//    typealias completionHandler = (String, [[String: String]]) -> Void
    
    let user = PublishSubject<User>()
    
    public func fetchData() {
        let api = SeSACAPI.signup(phoneNumber: "+821098894793", FCMtoken: "cwp44C15YkNjvgzwRXvkKM:APA91bGktTpQXzGk5DP6Oa660t6Q5aHU2D7cr_H8t3QhH7X_65uatr8hQyxxr805q9rNHYOaH2OT4GYqrAYsDYe6BBWssdg9t2F8l3it794lXmj-uEF1aSXQ5VNKQurDg36dqw5smY6d", email: "", birth: "", nick: "", gender: 0)
        Network.shared.requestSeSAC(type: User.self, url: api.url, method: .post, parameters: api.parameters, headers: api.headers) { response in
            switch response {
            case .success(let success):
                self.user.onNext(success)
                print("fetchData success", success)
            case .failure(let failure):
                self.user.onError(failure)
                print("fetchData failure", failure)
            }
        }
    }
}
