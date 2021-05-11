//
//  FirebaseSingleton.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import Foundation
import FirebaseDatabase
class FirebaseSingleton {
    private static var shared: FirebaseSingleton?
    
    // MARK: properties
    private var ref: DatabaseReference!
    
    private init(){
        self.ref = Database.database().reference();
    }
    
    static var instance: FirebaseSingleton? {
        get {
            guard let firebase = shared else {
                shared = FirebaseSingleton();
                return shared;
            }
            return firebase;
        }
    }
    
    
    func  insertUser (_ user : User )  {
        self.ref.child("users").child(user.username).setValue(["username": user.username,"password": user.password,"displayName": user.displayName,"image":user.image,"phoneNumber":user.phoneNumber,"friends":[],"status":true])
    }
    func  insertConversation(_ conversation: Conversation)  {
        let id = conversation.user1+conversation.user2
        self.ref.child("conversations").child(id).setValue(["user1":conversation.user1, "user2":conversation.user2,"status":conversation.status,"messages":conversation.messages])
        self.ref.child("users").child(conversation.user1).child("listConversationId").child(id).setValue(id)
        
        self.ref.child("users").child(conversation.user2).child("listConversationId").child(id).setValue(id)
    }
    func  insertMessage(message : ChatMessage , conversationId : String) {
        self.ref.child("conversations").child(conversationId).child("messages").setValue(["message":message.message , "sender" : message.sender])
    }
    
    // fetch data from realtime database by path
    func fetchData<T:Decodable>(path: String, comletionHandler: @escaping (T?, Error?) -> Void) {
        ref.child(path).observe(.value, with: { [weak self] (snapshot) in
            
            guard let value = snapshot.value as? [String:AnyObject] else {
                print("value nil ha ban")
                comletionHandler(nil, nil)
                return
            }
            print(value)
            var arr: [AnyObject] = [] // TH Fetch all
            for k in value{
                arr.append(k.value)
            }
            guard let data = try? JSONSerialization.data(withJSONObject: arr ) else {
                print("convert data từ arr ko dc ha ban")
                comletionHandler(nil, nil)
                return
            }
            print("=======Json ALL ======")
            print(arr)
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                print("do arr ha ban")
                comletionHandler(result, nil)
            } catch{ // TH fetch 1
                
                guard let data = try? JSONSerialization.data(withJSONObject: value ) else {
                    comletionHandler(nil, nil)
                    print("consert value ko dc ha ban")
                    return
                }
                print("=======json one======")
                print(value)
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    print("do value ha ban")
                    comletionHandler(result, nil)
                    
                } catch{
                    print("catch")
                    comletionHandler(nil, error)
                }
            }
        })
    }
 
    
}
