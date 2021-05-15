//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Admin on 10/05/2021.
//

import UIKit

class ConversationViewController : UIViewController {
    fileprivate let cellId = "MESSAGECELL"
    let host = User("TQH", "1", "image-3", "Trinh Hiep", "099863234")
 
    
    var client : String?
    
    @IBOutlet weak var txtfInput: UITextField!
    var existConversationId = ""
    var messages : [ChatMessage] = []
   
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = #colorLiteral(red: 0.9288164119, green: 0.9288164119, blue: 0.9288164119, alpha: 1)
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellId)
 
}
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
//       
        
    }
    
    func setUp(clientUsername: String,  conversationId : String)  {
        self.client = clientUsername
        
        let path = "INFOPUBLIC/"+clientUsername+"/listConversation"
        FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: { [self](data : [String]? , error : Error?)in
            guard let data = data else{
                return
            }
            for i in data{
                if i.contains(self.host.username) == true{
                                   existConversationId = i
                               }
            }
            if existConversationId == ""{
                            let con = Conversation(host.username, client!)
                            existConversationId = host.username + client!
                            FirebaseSingleton.instance?.insertConversation(conversation: con  )
                        }
            else{
                           FirebaseSingleton.instance?.fetchOne(path: "conversations/"+existConversationId+"/listMessage", completionHandler: { [self](data : [ChatMessage]?,err : Error? ) in
                               DispatchQueue.main.async {
                                   guard let data = data else{
                                       return
                                   }
           
                                   self.messages = data
                                   self.tableView.reloadData()
                               }
                           })
           
                       }
        })
//        DatabaseSupport.getUserById(id: clientUsername, completion: { [self](data : InfoPublic?) in
//            guard let data = data else {
//                return
//            }
//            for i in data.listConversationId{
//                if i.contains(self.host.username) == true{
//                    self.existConversationId = i
//
//                }
//            }
//            if self.existConversationId == ""{
//                let con = Conversation(host.username, client!)
//                self.existConversationId = host.username + client!
//                FirebaseSingleton.instance?.insertConversation(conversation: con  )
//            }
//            else{
//                FirebaseSingleton.instance?.fetchOne(path: "messages/"+existConversationId, completionHandler: { [self](data : [ChatMessage]?,err : Error? ) in
//                    DispatchQueue.main.async {
//                        guard let data = data else{
//                            return
//                        }
//
//                        self.messages = data
//                        self.tableView.reloadData()
//                    }
//                })
//
//            }
//
//        })

    }

    
    
    @IBAction func btnSend(_ sender: Any) {
        let message = txtfInput.text!
        guard message != "" else {
            return
        }
        let sender = self.host.username
        let chatMessage = ChatMessage(message: message, sender: sender)
        FirebaseSingleton.instance?.insertMessage(message: chatMessage, id: existConversationId)
        // update last message
        FirebaseSingleton.instance?.updateUserLastMessage(message: chatMessage, id: existConversationId)
        txtfInput.text = ""
        tableView.reloadData()
        
    }
    
  
    

}

extension ConversationViewController : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageTableViewCell
        let chatMessage = messages[indexPath.row]
        cell.chatMessage = chatMessage
        return cell
    }
    
}
//public extension String {
//  func indexInt(of char: Character) -> Int? {
//    return firstIndex(of: char)?.utf16Offset(in: self)
//  }
//}
