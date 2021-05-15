//
//  DatabaseSupport.swift
//  Messenger
//
//  Created by Admin on 13/05/2021.
//

import Foundation
class DatabaseSupport {
    
    
    static func getAllUser(completion :@escaping (_ users : [InfoPublic]?) -> Void ){
//        FirebaseSingleton.instance?.fetchAll(path: "infoPublic", completionHandler: { (data : [InfoPublic]? , error : Error?) in
//            DispatchQueue.main.async {
//                guard let data = data else{
//                    completion(nil)
//                    return
//                }
//                completion(data)
//            }
//        })
    }
    static func getMessageById(id : String ,completion :@escaping (_ message : [ChatMessage]?) -> Void ){
//        let path = "messages/"+id
//        FirebaseSingleton.instance?.fetchOneSingleEvent(path: path, completionHandler: { (data : [ChatMessage]? , error : Error?) in
//
//            DispatchQueue.main.async {
//                guard let data = data else{
//                    completion(nil)
//                    return
//                }
//                completion(data)
//            }
//        })
    }
    
    static func getConversationById(id : String , completion :@escaping (_ conversation : Conversation?) -> Void ){
//        let path = "conversations/"+id
//
//        FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: { (data : Conversation? , err : Error?) in
//
//            DispatchQueue.main.async {
//                guard let data = data else {
//                    completion(nil)
//                    return
//                }
//                completion(data)
//            }
//
//        })
    }
    
    static func getUserById(id : String , completion: @escaping(_ user : InfoPublic? ) ->Void)  {
//        let path = "infoPublic/"+id
//        FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: {(data : InfoPublic? , err: Error?) in
//            DispatchQueue.main.async {
//                guard let data = data else{
//                    completion(nil)
//                    return
//                }
//                completion(data)
//            }
//
//        })
    }
    
    static func updateListConversationId(username: String){
        let path = "INFOPUBLIC/"+username+"/listConversation"
        FirebaseSingleton.instance?.fetchAll(path: path, completionHandler: {(data : [String]? , error : Error?) in
            guard let data = data else {
                return
            }
            
            
        })
        
        
    }
    static func getListConversationByListId(host : String ,  completion:@escaping ([Conversation]?)->Void){
//        let path = "infoPublic/"+host
//        FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: {(data : InfoPublic? , err: Error?) in
//            DispatchQueue.main.async {
//                guard let data = data else{
//                    return
//                }
//                let listId = data.listConversationId
//                var list : [Conversation] = []
//                
//                for item in listId {
//                    let path1 = "conversations/"+item
//                    FirebaseSingleton.instance?.fetchOne(path: path1, completionHandler: { (data : Conversation? , err : Error?) in
//                        DispatchQueue.main.async {
//                            guard let data = data else {
//                                completion(nil)
//                                return
//                            }
//                        list.append(data)
//                        print("trong \(list)")
//                        }
//                            
//                    })
//
//                }
//                completion(list)
//                print(list)
//            }
//            
//        })
        
    }
    
}
