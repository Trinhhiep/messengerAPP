//
//  HomeViewController.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class HomeViewController: UIViewController {
    var textSearch : String?
    var host : String?
    var listConversationId : [String]?
    @IBOutlet weak var tableview: UITableView!
    
    // collection
    var infos : [InfoPublic]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaults = UserDefaults.standard
        self.host = defaults.string(forKey: "username")
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView()
        
        
        
     // default user
        guard  let username = self.host else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(identifier: "LOGIN") as! LoginViewController
            loginViewController.modalPresentationStyle = .fullScreen
            
            self.present(loginViewController, animated: true, completion: nil)
            
            
            return
        }
        
        // cell index = 1
       
        getListUserOnline()
        
        // cell index = 2
        let path = "INFOPUBLIC/"+username
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
        
       
    }
    func getListUserOnline(){
        guard self.host != nil else {
            return
        }
        FirebaseSingleton.instance?.fetchAll(path: "INFOPUBLIC", completionHandler: {(data : [InfoPublic]? , err : Error?) in
            DispatchQueue.main.async { [self] in
                guard let data = data else{
                    print (false)
                    return
                }
                if self.textSearch != nil && self.textSearch?.isEmpty == false{
                    self.infos = data.filter({(item : InfoPublic) in
                        return item.status == true && item.username != self.host &&  item.displayName.contains(textSearch!)
                    })
                }
                else{
                    self.infos = data.filter({(item : InfoPublic) in
                        return item.status == true && item.username != self.host
                    })
                }
            }
            self.tableview.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        
        
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
            searchBarCell.searchBar.delegate = self
            return searchBarCell
        }
        else if indexPath.row == 1{
            let userOnlineCell = tableview.dequeueReusableCell(withIdentifier: "USEROLINECELL") as! UserOnlineTableViewCell
            
           
            userOnlineCell.nav = self.navigationController
            guard  self.infos != nil else {
                return userOnlineCell
                
            }
            userOnlineCell.setUpCollection(infos: self.infos!)
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
extension HomeViewController : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        let text = searchBar.text
        self.textSearch = text
        getListUserOnline()

    }
    
    
}

