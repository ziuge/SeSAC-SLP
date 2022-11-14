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
    case login(email: String, password: String)
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
        case .signup, .login:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
                "idtoken": "eyJhbGciOiJSUzI1NiIsImtpZCI6ImQ3YjE5MTI0MGZjZmYzMDdkYzQ3NTg1OWEyYmUzNzgzZGMxYWY4OWYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc2VzYWMtMSIsImF1ZCI6InNlc2FjLTEiLCJhdXRoX3RpbWUiOjE2Njg0MjY5MDcsInVzZXJfaWQiOiI2ZWtXV1Z3QTdyWWRtOEEzc05uZmVjUWcxT3QyIiwic3ViIjoiNmVrV1dWd0E3cllkbThBM3NObmZlY1FnMU90MiIsImlhdCI6MTY2ODQyNjkwOCwiZXhwIjoxNjY4NDMwNTA4LCJwaG9uZV9udW1iZXIiOiIrODIxMDk4ODk0NzkzIiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrODIxMDk4ODk0NzkzIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGhvbmUifX0.p8ITAlsOa1pGq8NtBrbES2SHcYBIYA7adTmrL7J1nwVDslRnR0Gu9Xf-aoq1OxgDS10RFtrGC6E1bLBCqd2M8I7_DiPmK0Rfw9NFoGu7MOb6lQdfv2fJ4mdqY41E2GoA59ycyn0xShck0A2wvlaRI9i4ZKXNr3s8luQu2o5e7gxBAv4N0qYh4IWkyc9HioXcUll9gB8BiXlmF7qTnzIFhyXermdkvPdfBpc6yE-EGGtTVFbmouUSl0_Y7DQgLx4TKVje5X7YR3ILVtIMEniMZLEiPOpUgz3y4kRRQyuCIQQqtnF_lr6pmT02tBlPWCXc32Dw2aDkwZlCMnvGbuWRSA"
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
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return ["": ""]
        }
    }
}

