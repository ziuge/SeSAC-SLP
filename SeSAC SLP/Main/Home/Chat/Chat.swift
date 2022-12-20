//
//  Chat.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/04.
//

import Foundation

//struct Chat: Codable {
//    let id, to, from, chat: String
//    let createdAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case to, from, chat, createdAt
//    }
//}

// MARK: - Chat
struct Chat: Codable {
    let payload: [Payload]
}

// MARK: - Payload
struct Payload: Codable {
    let id, to, from, chat: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
}
