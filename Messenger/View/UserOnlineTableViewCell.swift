//
//  UserOnlineTableViewCell.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class UserOnlineTableViewCell: UITableViewCell {
    
    var host : String?
    var infos : [InfoPublic]?
    var navClosure : ((UIViewController)-> Void)?
    var nav : UINavigationController?
    @IBOutlet weak var collection: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let defaults = UserDefaults.standard
        self.host = defaults.string(forKey: "username")
        
        collection.dataSource = self
        collection.delegate = self
        FirebaseSingleton.instance?.fetchAll(path: "INFOPUBLIC", completionHandler: {(data : [InfoPublic]? , err : Error?) in
            DispatchQueue.main.async {
                guard let data = data else{
                    print (false)
                    return
                }
                self.infos = data.filter({(item : InfoPublic) in
                    return item.status == true && item.username != self.host
                })
                self.collection.reloadData()
            }
        })
    }}
extension UserOnlineTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return infos?.count ?? 0
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userCell = collection.dequeueReusableCell(withReuseIdentifier: "USERCELL", for: indexPath) as! UserOnlineCollectionViewCell
        userCell.updateUI(infos![indexPath.row])
        return userCell
    }
}

extension UserOnlineTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let conversationViewController = sb.instantiateViewController(identifier: "CONVERSATION") as! ConversationViewController
        let client = infos![indexPath.row]
        let id = "TVD"+client.username
        conversationViewController.setUpConversation(hostUsername: self.host!, clientUsername: client.username, conversationId: id)
       nav?.pushViewController(conversationViewController, animated: true)
    }
}
extension UserOnlineTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 150)
    }
}
