//
//  FirebaseSingleton.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import Foundation
import FirebaseDatabase
struct test {
    var id : String
    var arr : [Int]
    
    init(id : String ) {
        self.id = id
        self.arr = []
        
    }
}
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
    
    
    func  insertUser (user : User )  {
        
        var infoPublic = InfoPublic(user.username, user.image, user.displayName, user.phoneNumber)
        infoPublic.listConversation = [""]
        self.ref.child("private").child(user.username).setValue(["username": user.username,"password": user.password, "displayName": user.displayName, "image":user.image,"phoneNumber":user.phoneNumber, "status": user.status])
        insertInfoPublic(info: infoPublic)
        
    }
    func insertInfoPublic(info : InfoPublic)  {
        self.ref.child("INFOPUBLIC").child(info.username).setValue(["username": info.username, "displayName": info.displayName,"listConversation": info.listConversation, "image":info.image, "status": info.status])
        
    }
    
    
    func insertConversation(conversation : Conversation)  {
        let id = conversation.user1+conversation.user2
        self.ref.child("conversations").child(id).setValue(["user1":conversation.user1 , "user2":conversation.user2 , "status": conversation.status , "listMessage" : conversation.listMessage?.toDictionary()])
        
        let path1 = "INFOPUBLIC/"+conversation.user1
        self.fetchOneSingleEvent(path: path1, completionHandler: {(data : InfoPublic? , error : Error? )in
                   guard var data = data else{
                       return
                   }
            data.listConversation.append(id)
            self.insertInfoPublic(info: data)
            
        })
        let path2 = "INFOPUBLIC/"+conversation.user2
        self.fetchOneSingleEvent(path: path2, completionHandler: {(data : InfoPublic? , error : Error? )in
                   guard var data = data else{
                       return
                   }
            data.listConversation.append(id)
            self.insertInfoPublic(info: data)
            
        })
        print("Insert conversation is success.")
        
    }
  
   
    
    
    func insertMessage(message  : ChatMessage, id : String)  {
        let path = "conversations/"+id+"/listMessage"
        self.fetchOneSingleEvent(path: path, completionHandler: { [self](data : [ChatMessage]?,err : Error? ) in
            DispatchQueue.main.async {
                guard var data = data else{
                    return
                }
                data.append(message)
                self.ref.child(path).setValue(data.toDictionary())
            }
        })
        
      
        
    }
    
    
    func  updateUserLastMessage(message : ChatMessage ,id : String ) {
        //        self.fetchOneSingleEvent(path: "conversations/"+id, completionHandler: {(data : Conversation? , error : Error? )in
        //            guard let data = data else{
        //                return
        //            }
        //            var temp = data
        //            temp.lastMessage = message
        //            self.insertConversation(conversation: temp)
        //            print("Update last message for info public is success.")
        //        })
        
    }
    
    
    // fetch data from realtime database by path
    //        func fetchData<T:Decodable>(path: String, completionHandler: @escaping (T?, Error?) -> Void) {
    //            ref.child(path).observe(.value, with: { [weak self] (snapshot) in
    //
    //                guard let value = snapshot.value as? [String:Any] else {
    //                    completionHandler(nil, nil)
    //                   print (false)
    //                    return
    //                }
    //
    //                print(value)
    //                guard let data = try? JSONSerialization.data(withJSONObject: value.values ) else {
    //                    completionHandler(nil, nil)
    //                    return
    //                }
    //                do{
    //                    let result = try JSONDecoder().decode(T.self, from: data)
    //                    completionHandler(result, nil)
    //                } catch{ // TH fetch 1
    //
    //                    completionHandler(nil, error)
    //                }
    //            })
    //        }
    //
    //
    func  fetchAll <T:Codable>(path : String , completionHandler: @escaping (T? , Error?)  -> Void) {
        
        ref.child(path).observe(.value, with: {[weak self]  (snapshot ) in
            
            guard let value = snapshot.value as? [String:Any] else{
                completionHandler(nil, nil)
                print("Snapshot of \(type(of: [T].self)) is nil.")
                return
            }
            print(value)
            var arr : [Any] = []
            for i in value{
                arr.append(i.value)
            }
            guard let data = try? JSONSerialization.data(withJSONObject: arr ) else {
                completionHandler(nil, nil)
                return
            }
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                
                                print("Decode \(type(of: T.self)) success.")
                completionHandler(result, nil)
            } catch{
                
                                print("Decode \(type(of: T.self)) failure.")
                completionHandler(nil, error)
            }
            
            
        })
        
    }
    
        func  fetchOne <T:Codable>(path : String , completionHandler: @escaping (T? , Error?)  -> Void) {
    
            ref.child(path).observe(.value , with: {[weak self]  (snapshot ) in
                guard let value = snapshot.value  else{
                    completionHandler(nil, nil)
                    print("Snapshot \(type(of: T.self)) is nil.")
                    return
                }
                guard let data = try? JSONSerialization.data(withJSONObject: value ) else {
                    completionHandler(nil, nil)
                    return
                }
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    
                                    print("Decode \(type(of: T.self)) success.")
                    completionHandler(result, nil)
                } catch{
                    
                                    print("Decode \(type(of: T.self)) failure.")
                    completionHandler(nil, error)
                }
                
            })
    
        }
        func  fetchOneSingleEvent <T:Codable>(path : String , completionHandler: @escaping (T? , Error?)  -> Void) {
            ref.child(path).observeSingleEvent(of: .value , with: {[weak self]  (snapshot ) in
                guard let value = snapshot.value  else{
                    completionHandler(nil, nil)
                    print("Snapshot \(type(of: T.self)) is nil.")
                    return
                }
                guard let data = try? JSONSerialization.data(withJSONObject: value ) else {
                    completionHandler(nil, nil)
                    return
                }
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    
                                    print("Decode \(type(of: T.self)) success.")
                    completionHandler(result, nil)
                } catch{
                    
                                    print("Decode \(type(of: T.self)) failure.")
                    completionHandler(nil, error)
                }
                
            })
    
        }
    
}
