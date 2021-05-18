//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Admin on 18/05/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let host = defaults.string(forKey: "username")
        guard  host != nil else {
            return
        }
        let path = "private/"+host!
        FirebaseSingleton.instance?.fetchOneSingleEvent(path: path, completionHandler: { [self](data : User? ,  error : Error?)in
            guard let data = data else {
                return
            }
            image.image = UIImage(named: data.image)
            lblUsername.text = data.username
            lblDisplayName.text = data.displayName
            lblPhoneNumber.text = data.phoneNumber
            
        })
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
   
    @IBAction func btnLogOut(_ sender: Any) {
        defaults.setValue(nil, forKey: "username")
            defaults.setValue(nil, forKey: "password")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "LOGOUT") as! LoginViewController
        loginViewController.modalPresentationStyle = .fullScreen
        
        self.present(loginViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnChangePass(_ sender: Any) {
        
    }
}
