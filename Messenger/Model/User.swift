//
//  User.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import Foundation
protocol Dictionable {
    func  toDictionary() -> [String:Any]
}

struct User : Codable , Dictionable{
    func toDictionary() -> [String : Any] {
        var dic : [String:Any] = [:]
        dic.updateValue(username as Any, forKey: "username")
        dic.updateValue(password as Any, forKey: "password")
        dic.updateValue(displayName as Any, forKey: "displayName")
        dic.updateValue(image as Any, forKey: "image")
        dic.updateValue(phoneNumber as Any, forKey: "phoneNumber")
        dic.updateValue(status as Any, forKey: "status")
        return dic
    }
    
    var username : String
    var password : String
    var displayName : String
    var image : String
    var phoneNumber : String
    var status : Bool
    
    
   
        init(_ username : String , _ password : String, _ displayName : String, _ phoneNumber : String ) {
            self.username = username
            self.password = password
            self.image = "imagePlaceHolder"
            self.displayName = displayName
            self.phoneNumber = phoneNumber
            self.status = true
        }
}
struct InfoPublic : Codable , Dictionable {
    func toDictionary() -> [String : Any] {
        var dic : [String:Any] = [:]
        dic.updateValue(username as Any, forKey: "username")
        dic.updateValue(displayName as Any, forKey: "displayName")
        dic.updateValue(image as Any, forKey: "image")
        dic.updateValue(status as Any, forKey: "status")
        dic.updateValue(listConversation as Any, forKey: "listConversation")
        return dic
    }
    
    var username: String
    var displayName : String
    var image : String
    var status : Bool
    var listConversation :  [String]
    
    init(_ username : String ,  _ displayName : String, _ phoneNumber : String ) {
        self.username = username
        self.image = "imagePlaceHolder"
        self.displayName = displayName
        self.status = true
        self.listConversation = [""]
    }
    
    enum InfoPublicKey : String, CodingKey{
        case username = "username"
        case displayName = "displayName"
        case image = "image"
        case friends = "friends"
        case status = "status"
        case listConversation = "listConversation"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: InfoPublicKey.self)
        username = try container.decode(String.self, forKey: .username)
        displayName = try container.decode(String.self, forKey: .displayName)
        image = try container.decode(String.self, forKey: .image)
        status = try container.decode(Bool.self, forKey: .status)
        listConversation = try container.decode([String].self, forKey: .listConversation)

    }
//    func encode(from encoder:Encoder) throws {
//        var container = encoder.container(keyedBy: InfoPublicKey.self)
//        try container.encode(username, forKey: .username)
//        try container.encode(displayName, forKey: .displayName)
//        try container.encode(image, forKey: .image)
//        try container.encode(friends, forKey: .friends)
//        try container.encode(status, forKey: .status)
//        try container.encode(listConversation, forKey: .listConversation)
//    }
}
extension Array : Dictionable where Element : Dictionable{
    func toDictionary() -> [String : Any] {
        var dic : [String : Any] = [:]
        for (index , item) in self.enumerated(){
            dic.updateValue(item.toDictionary(), forKey: "\(index)")
        }
        return dic
    }
    
    
}
