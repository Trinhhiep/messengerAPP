//
//  Conversation.swift
//  Messenger
//
//  Created by Admin on 10/05/2021.
//

import Foundation
struct Conversation : Decodable {
    var user1 : String
    var user2 : String
    var messages : [ChatMessage]
    var status : Bool
    
    init(_ user1: String, _ user2: String) {
        self.user1 = user1
        self.user2 = user2
        self.messages = []
        self.status = true
    }
    
    enum ConversationKey : String, CodingKey{
        case user1 = "user1"
        case user2 = "user2"
        case messages = "massages"
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ConversationKey.self)
        user1 = try container.decode(String.self, forKey: .user1)
        user2 = try container.decode(String.self, forKey: .user2)
        messages = try container.decode([ChatMessage].self, forKey: .messages)
        status = try container.decode(Bool.self, forKey: .status)
        }
//    func encode(from encoder:Encoder) throws {
//        var container = encoder.container(keyedBy: InfoPublicKey.self)
//        try container.encode(displayName, forKey: .displayName)
//        try container.encode(image, forKey: .image)
//        try container.encode(status, forKey: .status)
//    }
}
struct ChatMessage : Decodable{
    var sender : String
    var message : String
    enum MessageKey : String, CodingKey {
        case sender = "sender"
        case message = "message"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MessageKey.self)
        sender = try container.decode(String.self, forKey: .sender)
        message = try container.decode(String.self, forKey: .message)
    }
    init( message : String,  sender : String) {
        self.message = message
        self.sender = sender
    }
}
