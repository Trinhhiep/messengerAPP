//
//  UserOnlineTableViewCell.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class UserOnlineTableViewCell: UITableViewCell {
    var infos : [InfoPublic]?
    var navClosure : ((UIViewController)-> Void)?
    var nav : UINavigationController?
    @IBOutlet weak var collection: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        collection.dataSource = self
        collection.delegate = self
        
   
        FirebaseSingleton.instance?.fetchData(path: "users", comletionHandler: { [weak self] (data : [InfoPublic]? , error : Error?) in
            DispatchQueue.main.async {
                guard let data = data else{
                    print("data nil ma ab")
                    return
                }
            self!.infos = data.filter{ (item ) -> Bool in
                
                    return item.status == true
                }
            self!.collection.reloadData()
                
           }
            
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        }
    
        
 
    

}
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
        conversationViewController.setUp(info: infos![indexPath.row])
        //check room is exist ?
        // insert room
       nav?.pushViewController(conversationViewController, animated: true)

    }
}
extension UserOnlineTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 150)
    }
}
