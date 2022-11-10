//
//  Endpoint.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/10.
//

import Foundation
import Alamofire

enum SeSACAPI {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
}

extension SeSACAPI {
    var url: URL {
        switch self {
        case .signup:
            return URL(string: "http://api.sesac.co.kr:1207/v1/users/")!
        case .login:
            return URL(string: "http://api.sesac.co.kr:1207/v1/users/")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
//        case .profile:
//            return [
//                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
//                "Content-Type": "application/x-www-form-urlencoded"
//            ]
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .signup(let username, let email, let password):
            return [
                "userName": username,
                "email": email,
                "password": password
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

