//
//  HomeViewController.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class HomeViewController: UIViewController {
    let host = User("TQH", "1", "image-3", "Trinh Hiep", "099863234")
//    var conversations : [Conversation]?
    var listConversationId : [String]?
    @IBOutlet weak var tableview: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
       
//        setUp()
        
        
        let path = "INFOPUBLIC/"+host.username+"/listConversation"
        
        FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: {(data : [String]? , err : Error?) in
            DispatchQueue.main.async {
                guard let data = data else{
                    print (false)
                    return
                }
                self.listConversationId = data.filter({
                    return $0 != ""
                })
                print(self.listConversationId!)
                self.tableview.reloadData()
            }
            
          
        })
//        let u = User("TQH", "1", "image-1", "Trinh Hiep", "23786429380")
//        let u1 = User("TVD", "1", "image-2", "To Vu Duong", "23786429380")
//        let u2 = User("LAH", "1", "image-3", "Le Anh Hoa", "23786429380")
//        FirebaseSingleton.instance?.insertUser(user: u)
//        FirebaseSingleton.instance?.insertUser(user: u1)
//        FirebaseSingleton.instance?.insertUser(user: u2)

//        var c = Conversation("TQH", "LAH")
//        let chat = ChatMessage(message: "alo", sender: "TQH")
//
//        let chat2 = ChatMessage(message: "aloooo", sender: "TQH")
//        c.listMessage?.append(chat)
//        c.listMessage?.append(chat2)
//
//        FirebaseSingleton.instance?.insertConversation(conversation: c)
        

//        FirebaseSingleton.instance?.fetchData(path: "listConversation/TQHLAH", completionHandler: {(data : Conversation? , err: Error?)in
//            guard let data = data else{
//                print(false)
//                return
//            }
//            print(data.user1)
//        })
//        FirebaseSingleton.instance?.fetchData(path: "INFOPUBLIC/TQH", completionHandler: {(data : InfoPublic? , err: Error?)in
//            guard let data = data else{
//                print(false)
//                return
//            }
//            print(data.displayName)
//        })
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    func setUp()  {
        
    }
   
    
}
extension HomeViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  listConversationId?.count ?? 0 + 2
        
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let searchBarCell = tableview.dequeueReusableCell(withIdentifier: "SEARCHBARCELL") as! SearchBarTableViewCell
            return searchBarCell
        }
        else if indexPath.row == 1{
            let userOnlineCell = tableview.dequeueReusableCell(withIdentifier: "USEROLINECELL") as! UserOnlineTableViewCell
            userOnlineCell.nav = self.navigationController
            return userOnlineCell
        }
        let conversationCell = tableview.dequeueReusableCell(withIdentifier: "CONVERSATIONCELL") as! ConversationTableViewCell
        conversationCell.setUp(conversationId: listConversationId![indexPath.row - 2])
        print("============")
        print(listConversationId![indexPath.row - 2])
        return conversationCell
    }
    
    
}
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        if indexPath.row == 0 {
            height = 60
        }else if indexPath.row == 1 {
            height = 150
        }
        else {
            height = 80
        }
        return height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let conversationViewController = sb.instantiateViewController(identifier: "CONVERSATION") as! ConversationViewController
        
//        let conversation = conversations![indexPath.row-2]
//
//        let client = host.username == conversation.user1 ? conversation.user2 : conversation.user1
//        let id = host.username + client
//
//        conversationViewController.setUp(clientUsername: client ,  conversationId: id)
//
                
        
        self.navigationController!.pushViewController(conversationViewController, animated: true)
    }
    
}
