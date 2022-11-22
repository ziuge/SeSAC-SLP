//
//  SignupData.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/11/14.
//

import Foundation

struct SignupDetails {
    static var details: SignupDetails = SignupDetails()
    
    var phoneNumber: String = "+821098894793"
    var FCMtoken: String = ""
    var nick: String = ""
    var birth: String = ""
    var email: String = ""
    var gender: Int = 0
}

struct LoginDetails {
    static var details: LoginDetails = LoginDetails()
    
    var id: String = ""
    var reputation: [Int] = []
    var comment: [String] = []
    var sesacCollection: [Int] = []
    var backgroundCollection: [Int] = []
    var purchaseToken: [String] = []
    var transactionID: [String] = []
    var reviewedBefore: [String] = []
    var reportedUser: [String] = []
    var uid: String = ""
    var phoneNumber: String = ""
    var fcMtoken: String = ""
    var nick: String = ""
    var birth: String = ""
    var email: String = ""
    var gender: Int = 0
    var sesac: Int = 0
    var study: String = ""
    var dodgepenalty: Int = 0
    var background: Int = 0
    var ageMin: Int = 0
    var ageMax: Int = 0
    var dodgeNum: Int = 0
    var searchable: Int = 0
    var reportedNum: Int = 0
    var createdAt: String = ""
    var v: Int = 0
}
