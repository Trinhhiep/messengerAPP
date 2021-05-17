//
//  ConversationTableViewCell.swift
//  Messenger
//
//  Created by Admin on 07/05/2021.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    var host : String?
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var lblLastMessage: UILabel!
    @IBOutlet weak var btnProfile: PersonalButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let defaults = UserDefaults.standard
        self.host = defaults.string(forKey: "username")
        // Initialization code
    }
    func setUp(conversationId : String){
        let path1 = "conversations/"+conversationId
        FirebaseSingleton.instance?.fetchOne(path: path1, completionHandler: { [self](data : Conversation? , error : Error?) in
            guard let data = data else{
                print(false)
                return
            }
            
            let endMess:ChatMessage = (data.listMessage?.last)!
            lblLastMessage.text = endMess.message
            lblTime.text = endMess.time
            let client = host! == data.user1 ? data.user2 : data.user1
            let path = "INFOPUBLIC/"+client
            FirebaseSingleton.instance?.fetchOne(path: path, completionHandler: { [self]( data : InfoPublic? , error : Error?)in
                guard let data = data else{
                    return
                }
                lblDisplayName.text = data.displayName
                btnProfile.addImageView(image: UIImage(named: data.image)!, status: data.status)
          
            })
        })
        
        
       
                     
    }
    
   
   

}
extension Array {
    var last: Element{
        return self[self.endIndex - 1]
    }
}
