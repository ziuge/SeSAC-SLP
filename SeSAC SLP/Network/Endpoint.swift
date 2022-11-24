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
    case main(lat: Double, long: Double)
}

extension SeSACAPI {
    var url: URL {
        switch self {
        case .signup:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/")!
        case .login:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/")!
        case .main:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/search")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idtoken": APIKey.authorization
            ]
        case .login:
            return [
                "idtoken": APIKey.authorization
            ]
        case .main:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idtoken": APIKey.authorization
            ]
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
        case .main(let lat, let long):
            return [
                "lat": "\(lat)",
                "long": "\(long)"
            ]
        default: return ["": ""]
        }
    }
}

