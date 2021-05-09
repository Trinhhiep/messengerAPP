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
        self.ref.child("users").child(user.username).setValue(["username": user.username,"password": user.password,"displayName": user.displayName,"phoneNumber":user.phoneNumber,"friends":[],"status":true])
    }
 
    // fetch data from realtime database by path
    func fetchData<T:Decodable>(path: String, comletionHandler: @escaping (T?, Error?) -> Void) {
        ref.child(path).observe(.value, with: { (snapshot) in
            guard let value = snapshot.value else {
                comletionHandler(nil, nil)
                return
            }
            guard let data = try? JSONSerialization.data(withJSONObject: value) else {
                comletionHandler(nil, nil)
                return
            }
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                comletionHandler(result, nil)
            } catch{
                comletionHandler(nil, error)
            }
        })
    }
}

