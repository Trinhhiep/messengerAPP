//
//  UserOnlineTableViewCell.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class UserOnlineTableViewCell: UITableViewCell {
    var users : [User]?
    
    @IBOutlet weak var collection: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        collection.dataSource = self
        collection.delegate = self
        
        DispatchQueue.global().async {
            FirebaseSingleton.instance?.fetchData(path: "users/TQH", comletionHandler: { (data : User? , error : Error?) in
                print(data!)
            })
            
        }
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        }
    
        
        
    

}
extension UserOnlineTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return users!.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userCell = collection.dequeueReusableCell(withReuseIdentifier: "USERCELL", for: indexPath) as! UserOnlineCollectionViewCell
//        userCell.updateUI(users![indexPath.row])
        return userCell
    }
    
    
}

extension UserOnlineTableViewCell: UICollectionViewDelegate{
    
}
extension UserOnlineTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 120)
    }
}
