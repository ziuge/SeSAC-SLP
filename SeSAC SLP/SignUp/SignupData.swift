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
