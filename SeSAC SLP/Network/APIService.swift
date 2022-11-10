//
//  APIService.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/10.
//

import Alamofire
import Foundation

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let nick: String
    let email: String
    let birth: String
    let gender: Bool
    let phoneNumber: String
    let FCMtoken: String
}

enum SeSACError: Int, Error {
    case takenEmail = 201
    case unusableNick = 202
    case firebaseTokenError = 401
    case notSignedUp = 406
    case serverError = 500
    case clientError = 501
}

extension SeSACError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .unusableNick:
            return "사용할 수 없는 닉네임입니다."
        case .firebaseTokenError:
            return "Firebase Token Error"
        case .notSignedUp:
            return "미가입 회원입니다."
        case .serverError:
            return "Server Error"
        case .clientError:
            return "Client Error"
        }
    }
}

class APIService {
//    func signup() {
//        let api = SeSACAPI.signup(userName: "testZiuge", email: "testZiuge@testZiuge.com", password: "12345678")
//        
//        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
//            .responseString { response in
//                print(response)
//                print(response.response?.statusCode)
//            }
//    }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod, parameters: [String: String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSACError(rawValue: statusCode) else { return }
                
                completion(.failure(error))
            }
        }
    }
}
