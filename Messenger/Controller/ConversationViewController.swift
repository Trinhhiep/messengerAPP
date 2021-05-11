//
//  ConversationViewController.swift
//  Messenger
//
//  Created by Admin on 10/05/2021.
//

import UIKit

class ConversationViewController : UIViewController {
    fileprivate let cellId = "MESSAGECELL"
  let host = "TQH"
    @IBOutlet weak var txtfInput: UITextField!
    let messages: [ChatMessage] = [ChatMessage(message: "Cuốn sách Nhà Giả Kim của Paulo Coelho là cuốn sách rất hay mà mình từng đọc.", sender: "TVD"),ChatMessage(message: "Nội dung cuốn sách xoay quanh câu chuyện cậu bé chăn cừu Santiago và cuộc hành trình đi tìm kho báu của cậu.", sender: "TQH"),ChatMessage(message: "Cuộc hành trình đó đã dạy cho cậu rất nhiều bài học về cuộc sống.", sender: "TVD"),ChatMessage(message: "ok.", sender: "TVD"),ChatMessage(message: "Giúp cho cậu nhận ra được mục đích và ý nghĩa của cuộc đời mình.", sender: "TQH"),ChatMessage(message: "Cuộc hành trình đó đã dạy cho cậu rất nhiều bài học về cuộc sống.", sender: "TVD"),ChatMessage(message: "ok.", sender: "TVD"),ChatMessage(message: "Giúp cho cậu nhận ra được mục đích và ý nghĩa của cuộc đời mình.", sender: "TQH")]
   
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = #colorLiteral(red: 0.9288164119, green: 0.9288164119, blue: 0.9288164119, alpha: 1)
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellId)
        //check room is exist ?
        
        // insert room

}
    func insertNewConversation(usernameClient : String)  {
        let path = "users/"+usernameClient+"/listConversationId"
        var isExistConversation = ""
        FirebaseSingleton.instance?.fetchData(path: path, comletionHandler: { (data : [String]? , error : Error?) in
            for i in data!{
                if i.contains(self.host){
                    isExistConversation = i
                    return
                }
            }


            if isExistConversation == ""{

                let conversation = Conversation(self.host, usernameClient)

                FirebaseSingleton.instance?.insertConversation(conversation)

            }
            else{
                // lay data chat 
            }

        })
    }
    
    @IBAction func btnSend(_ sender: Any) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    func setUp(info : InfoPublic)  {
        navigationItem.title = info.displayName
        
        insertNewConversation(usernameClient: info.username)
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
