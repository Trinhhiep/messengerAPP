//
//  User.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import Foundation
class User : Decodable {
    var username : String
    var password : String
    var displayName : String
    var image : String
    var phoneNumber : String
    var friends : [String]
    var status : Bool
    
    
    enum UserKey : String, CodingKey{
        case displayName = "displayName"
        case username = "username"
        case password = "password"
        
        case image = "image"
        case phoneNumber = "phoneNumber"
        case friends = "friends"
        case status = "status"
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKey.self)
        displayName = try container.decode(String.self, forKey: .displayName)
        image = try container.decode(String.self, forKey: .image)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        friends = try container.decode([String].self, forKey: .friends)
        status = try container.decode(Bool.self, forKey: .status)
        username = try container.decode(String.self, forKey: .username)
        password = try container.decode(String.self, forKey: .password)
    }
    //    init(_ username : String , _ password : String ,_ image: String, _ displayName : String, _ phoneNumber : String ) {
    //        self.username = username
    //        self.password = password
    //        self.image = image
    //        self.displayName = displayName
    //        self.phoneNumber = phoneNumber
    //        self.friends = []
    //        self.status = true
    //
    //    }
}
