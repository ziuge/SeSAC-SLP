//
//  Network.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/10.
//

import Alamofire
import Foundation

final class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod = .get, parameters: [String: String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
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
