//
//  HomeViewController.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class HomeViewController: UIViewController {
   
    var username : String?
    var listConversationId : [String]?
    
    @IBOutlet weak var tableview: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        self.username = defaults.string(forKey: "username")
        
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView()
        
        let path = "INFOPUBLIC/"+self.username!
        FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: {(data : InfoPublic? , err : Error?) in
            DispatchQueue.main.async {
                guard let data = data else{
                    print (false)
                    return
                }
                self.listConversationId = data.listConversation.filter({
                    return $0 != ""
                })
                
                self.tableview.reloadData()
            }
            
          
        })
        
//        let path = "INFOPUBLIC/"+self.username!+"/listConversation"
//
//        FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: {(data : [String]? , err : Error?) in
//            DispatchQueue.main.async {
//                guard let data = data else{
//                    print (false)
//                    return
//                }
//                self.listConversationId = data.filter({
//                    return $0 != ""
//                })
//
//                self.tableview.reloadData()
//            }
//
//
//        })
        
       
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
       let count = listConversationId?.count ?? 0
        return  count + 2
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
        else{
            
            let conversationCell = tableview.dequeueReusableCell(withIdentifier: "CONVERSATIONCELL") as! ConversationTableViewCell
            
           
            conversationCell.setUp(conversationId: (listConversationId?[indexPath.row - 2])!)
            
            return conversationCell
        }
       
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
        
        conversationViewController.loadExistConversation(conversationId: (listConversationId?[indexPath.row - 2])!)

                
        
        self.navigationController!.pushViewController(conversationViewController, animated: true)
    }
    
}
