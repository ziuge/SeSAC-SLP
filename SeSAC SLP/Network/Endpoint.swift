//
//  Endpoint.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/10.
//

import Foundation
import Alamofire

enum SeSACAPI {
    case signup(phoneNumber: String, FCMtoken: String, email: String, birth: String, nick: String, gender: Int)
    case login
}

extension SeSACAPI {
    var url: URL {
        switch self {
        case .signup:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user/")!
        case .login:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user/")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idtoken": (UserDefaults.standard.string(forKey: "idToken") != nil) ? UserDefaults.standard.string(forKey: "idToken")! : ""
            ]
        case .login:
            return [
                "idtoken": (UserDefaults.standard.string(forKey: "idToken") != nil) ? UserDefaults.standard.string(forKey: "idToken")! : ""
            ]
//        case .profile:
//            return [
//                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
//                "Content-Type": "application/x-www-form-urlencoded"
//            ]
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .signup(let phoneNumber, let FCMtoken, let email, let birth, let nick, let gender):
            return [
                "phoneNumber": phoneNumber,
                "FCMtoken": FCMtoken,
                "nick": nick,
                "birth": birth,
                "email": email,
                "gender": "\(gender)"
            ]
        default: return ["": ""]
        }
    }
}

