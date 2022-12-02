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
    case state // 새싹 상태
    case main(lat: Double, long: Double) // 새싹 홈화면
    case find(lat: Double, long: Double, studylist: Array<String>) // 새싹 찾기 요청
    case studyrequest(otheruid: String)
}

extension SeSACAPI {
    var url: URL {
        switch self {
        case .signup:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/")!
        case .login:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/")!
        case .state:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/myQueueState")!
        case .main:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/search")!
        case .find:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/")!
        case .studyrequest:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/studyrequest")!
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
        case .state:
            return [
                
            ]
        case .main:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idtoken": APIKey.authorization
            ]
        case .studyrequest(otheruid: let otheruid):
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
        case .studyrequest(let otheruid):
            return [
                "otheruid": otheruid
            ]
        default: return ["": ""]
        }
    }
}

