//
//  SocketIOManager.swift
//  SeSAC SLP
//
//  Created by CHOI on 2022/12/14.
//

import Foundation
import SocketIO

class SocketIOManager {
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고받기 위한 클래스
    var manager: SocketManager!
    
    var socket: SocketIOClient!
    
    private init() {
        let api = SeSACAPI.getchat(otheruid: <#T##String#>, lastchatdate: <#T##String#>)
        manager = SocketManager(socketURL: URL(string: APIKey.baseURL)!, config: [
//            .log(true),
            .extraHeaders(["auth": APIKey.authorization])
        ])
        
        socket = manager.defaultSocket
        
        // 연결
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        
        // 연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        // 이벤트 수신
        socket.on("sesac") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let userId = data["userId"] as! String
            let createdAt = data["createdAt"] as! String
            
            print("CHECK >>>", chat, name, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "name": name, "createdAt": createdAt, "userId": userId])
        }
        
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
        
}
