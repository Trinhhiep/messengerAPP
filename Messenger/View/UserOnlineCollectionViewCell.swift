//
//  UserOnlineCollectionViewCell.swift
//  Messenger
//
//  Created by Admin on 07/05/2021.
//

import UIKit

class UserOnlineCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var btnProfile: PersonalButton!
    @IBOutlet weak var lblDisplayName: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func btnProfileClicked(_ sender: Any) {
    }
    
    func updateUI(_ info : InfoPublic) {
        lblDisplayName.text = info.displayName
        btnProfile.addImageView(image: UIImage(named: info.image)!, status : info.status)
    }
}
