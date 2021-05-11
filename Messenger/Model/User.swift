//
//  User.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import Foundation
struct User : Codable {
    var username : String
    var password : String
    var displayName : String
    var image : String
    var phoneNumber : String
    var friends : [String]
    var status : Bool
    var listConversationId :  [String]
    
   
        init(_ username : String , _ password : String ,_ image: String, _ displayName : String, _ phoneNumber : String ) {
            self.username = username
            self.password = password
            self.image = image
            self.displayName = displayName
            self.phoneNumber = phoneNumber
            self.friends = []
            self.status = true
            self.listConversationId = []
        }
}
struct InfoPublic : Decodable  {
    var username: String
    var displayName : String
    var image : String
    var status : Bool
    var listConversationId :  [String]
    
    enum InfoPublicKey : String, CodingKey{
        case username = "username"
        case displayName = "displayName"
        case image = "image"
        case status = "status"
        case listConversationId = "listConversationId"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: InfoPublicKey.self)
        username = try container.decode(String.self, forKey: .username)
        displayName = try container.decode(String.self, forKey: .displayName)
        image = try container.decode(String.self, forKey: .image)
        status = try container.decode(Bool.self, forKey: .status)
        listConversationId = try container.decode([String].self, forKey: .listConversationId)
        
    }
//    func encode(from encoder:Encoder) throws {
//        var container = encoder.container(keyedBy: InfoPublicKey.self)
//        try container.encode(displayName, forKey: .displayName)
//        try container.encode(image, forKey: .image)
//        try container.encode(status, forKey: .status)
//    }
}
