//
//  HomeViewController.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
//        let user = User("hiep123", "1", "hiep trinh", "0335322225")
//        let user2 = User("TVD", "1", "To Vu Duong", "0335322226")
//        let user3 = User("TQH", "1", "hiep trinh", "0335322227")
//        FirebaseSingleton.instance.insertUser(user)
//        FirebaseSingleton.instance.insertUser(user3)
//        FirebaseSingleton.instance.insertUser(user2)
    }

}
extension HomeViewController:UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let searchBarCell = tableview.dequeueReusableCell(withIdentifier: "SEARCHBARCELL") as! SearchBarTableViewCell
            return searchBarCell
        }
        else if indexPath.row == 1{
            let userOnlineCell = tableview.dequeueReusableCell(withIdentifier: "USEROLINECELL") as! UserOnlineTableViewCell
           
            return userOnlineCell
        }
        let conversationCell = tableview.dequeueReusableCell(withIdentifier: "CONVERSATIONCELL") as! ConversationTableViewCell
        return conversationCell
    }
    
    
}
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            var height:CGFloat = CGFloat()
            if indexPath.row == 1 {
                height = 150
            }
            else {
                height = 80
            }
            return height
        }
    
    
}
