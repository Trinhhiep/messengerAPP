//
//  Conversation.swift
//  Messenger
//
//  Created by Admin on 10/05/2021.
//

import Foundation
struct Conversation : Codable , Dictionable {
    func toDictionary() -> [String : Any] {
        var dic : [String: Any] = [:]
        dic.updateValue(user1 as Any, forKey: "user1")
        dic.updateValue(user2 as Any, forKey: "user2")
        dic.updateValue(status as Any, forKey: "status")
        dic.updateValue(listMessage as Any, forKey: "listMessage")
        return dic
    }
    
    var user1 : String
    var user2 : String
    var status : Bool
    var listMessage : [ChatMessage]?
    
    init(_ user1: String, _ user2: String) {
        self.user1 = user1
        self.user2 = user2
        self.status = true
        self.listMessage = [ChatMessage(message: "", sender: user1)]
    }
    
//    enum ConversationKey : String, CodingKey{
//        case user1 = "user1"
//        case user2 = "user2"
//        case status = "status"
//        case lastMessage = "lastMessage"
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: ConversationKey.self)
//        user1 = try container.decode(String.self, forKey: .user1)
//        user2 = try container.decode(String.self, forKey: .user2)
//        status = try container.decode(Bool.self, forKey: .status)
//        lastMessage = try container.decode(ChatMessage.self, forKey: .lastMessage)
//        }
//    func encode(from encoder:Encoder) throws {
//        var container = encoder.container(keyedBy: ConversationKey.self)
//        try container.encode(user1, forKey: .user1)
//        try container.encode(user2, forKey: .user2)
//        try container.encode(status, forKey: .status)
//        try container.encode(lastMessage, forKey: .lastMessage)
//    }
}
struct ChatMessage : Codable , Dictionable{
    func toDictionary() -> [String : Any] {
        var dic : [String: Any] = [:]
        dic.updateValue(sender as Any, forKey: "sender")
        dic.updateValue(message as Any, forKey: "message")
        dic.updateValue(time as Any, forKey: "time")
        return dic
    }
    var sender : String
    var message : String
    var time : String?
    
    init( message : String,  sender : String) {
        self.message = message
        self.sender = sender
        self.time = getCurrentTime()
    }
    private func getCurrentTime() -> String{
      return "1/1/2021 00:00"
    }
    
//    enum MessageKey : String, CodingKey {
//        case sender = "sender"
//        case message = "message"
//        case time = "time"
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MessageKey.self)
//        sender = try container.decode(String.self, forKey: .sender)
//        message = try container.decode(String.self, forKey: .message)
//        time = try container.decode(String.self, forKey: .time)
//    }
//
//    func encode(from encoder:Encoder) throws {
//           var container = encoder.container(keyedBy: MessageKey.self)
//           try container.encode(sender , forKey: .sender)
//           try container.encode(message, forKey: .message)
//        try container.encode(time, forKey: .time)
//       }
}
