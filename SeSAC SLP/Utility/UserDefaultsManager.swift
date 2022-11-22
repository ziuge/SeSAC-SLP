//
//  UserDefaultsManager.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/22.
//

import Foundation

struct UserDefaultsManager {
    @UserDefaultWrapper(key: "userinfo", defaultValue: UserInfo(id: "", reputation: [], comment: [], sesacCollection: [], backgroundCollection: [], purchaseToken: [], transactionID: [], reviewedBefore: [], reportedUser: [], uid: "", phoneNumber: "", fcMtoken: "", nick: "", birth: "", email: "", gender: 0, sesac: 0, study: "", dodgepenalty: 0, background: 0, ageMin: 0, ageMax: 0, dodgeNum: 0, searchable: 0, reportedNum: 0, createdAt: "", v: 0))
    static var userinfo: UserInfo
}

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
                    return lodedObejct
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
    
}
