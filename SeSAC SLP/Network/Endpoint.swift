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
    case stop // 새싹 찾기 중단
    case studyrequest(otheruid: String) // 새싹 매칭 요청
    case studyaccept(otheruid: String) // 새싹 매칭 수락
    case studydodge(otheruid: String) // 스터디 취소
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
        case .find, .stop:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/")!
        case .studydodge:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/dodge")!
        case .studyrequest:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/studyrequest")!
        case .studyaccept:
            return URL(string: APIKey.baseURL + "/v1/queue/studyaccept")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .main, .studyrequest, .find, .studydodge:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idtoken": APIKey.authorization
            ]
        case .login, .state, .studyaccept, .stop:
            return [
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
//        case .find(let lat, let long, let studylist):
//            return [
//                "lat": "\(lat)",
//                "long": "\(long)",
//                "studylist": studylist
//            ]
        case .studyrequest(let otheruid), .studyaccept(let otheruid), .studydodge(otheruid: let otheruid):
            return [
                "otheruid": otheruid
            ]
        default: return ["": ""]
        }
    }
}

