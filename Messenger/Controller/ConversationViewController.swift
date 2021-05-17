//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Admin on 10/05/2021.
//

import UIKit

class ConversationViewController : UIViewController {
    fileprivate let cellId = "MESSAGECELL"
    var host : String?
    var client : String?
    
    @IBOutlet weak var txtfInput: UITextField!
    var existConversationId = ""
    var messages : [ChatMessage] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        self.host = defaults.string(forKey: "username")
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = #colorLiteral(red: 0.9288164119, green: 0.9288164119, blue: 0.9288164119, alpha: 1)
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellId)
       
        
    }
    func setUpTittle()  {
        guard let username = self.client else {
            return
        }
        let pathDisplayName = "INFOPUBLIC/"+username
                        FirebaseSingleton.instance?.fetchOne(path: pathDisplayName, completionHandler: {(data : InfoPublic? , error : Error?) in
                            guard let data = data else{
                                return
                            }
                            self.title = data.displayName
                           
                        })
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    func setUpConversation(hostUsername : String ,clientUsername: String,  conversationId : String)  {
        self.client = clientUsername
       
        let path = "INFOPUBLIC/"+clientUsername+"/listConversation"
        FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: { [self](data : [String]? , error : Error?)in
            guard let data = data else{
                return
            }
            for i in data{
                if i.contains(hostUsername) == true{
                    existConversationId = i
                }
            }
            if existConversationId == ""{
                let con = Conversation(hostUsername, clientUsername)
                existConversationId = hostUsername + clientUsername
                FirebaseSingleton.instance?.insertConversation(conversation: con  )
            }
            else{
                FirebaseSingleton.instance?.fetchOne(path: "conversations/"+existConversationId+"/listMessage", completionHandler: { [self](data : [ChatMessage]?,err : Error? ) in
                    DispatchQueue.main.async {
                        guard let data = data else{
                            return
                        }
                        
                        self.messages = data.filter({
                            return $0.message != ""
                        })
                        self.tableView.reloadData()
                    }
                })
                
            }
        })
        setUpTittle()
    }
    func loadExistConversation(conversationId : String){
        self.existConversationId = conversationId
        FirebaseSingleton.instance?.fetchOne(path: "conversations/"+conversationId, completionHandler: { [self](data : Conversation?,err : Error? ) in
            DispatchQueue.main.async {
                guard let data = data else{
                    return
                }
                
                self.messages = data.listMessage!.filter({
                    return $0.message != ""
                })
                self.client = host! == data.user1 ? data.user2 : data.user1
                self.tableView.reloadData()
                setUpTittle()
            }
        })
       
        
    }
    
    
    @IBAction func btnSend(_ sender: Any) {
        let message = txtfInput.text!
        guard message != "" else {
            return
        }
        let sender = self.host!
        let chatMessage = ChatMessage(message: message, sender: sender)
        FirebaseSingleton.instance?.insertMessage(message: chatMessage, id: existConversationId)
        // update last message
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

