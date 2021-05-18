//
//  ChangePassViewController.swift
//  Messenger
//
//  Created by Admin on 18/05/2021.
//

import UIKit

class ChangePassViewController: UIViewController {

    let defaults = UserDefaults.standard
    var user : User?
    @IBOutlet weak var lblMess: UILabel!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var oldPass: UITextField!
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
            self.user = data
           
            oldPass.isSecureTextEntry = true

            newPass.isSecureTextEntry = true
            confirm.isSecureTextEntry = true
        })
    }
    
    @IBAction func btnSave(_ sender: Any) {
        guard  oldPass.text == user?.password else {
            self.showMessage(message: "Old password is wrong!", lbl: lblMess, type: false)
           
            return
        }
        guard newPass.text!.count >= 8 else {
            
            self.showMessage(message: "Password length greater than 8 characters!", lbl: lblMess, type: false)
           
            return
        }
        guard newPass.text == confirm.text else {
            
           
            showMessage(message: "Invalid confirm password!", lbl: lblMess, type: false)
            
            return
        }
        guard let user = self.user else {
            return
        }
        let password = newPass.text
        
        FirebaseSingleton.instance?.changePassword(username: user.username, pass: password!)
        self.showMessage(message: "Register successfull!", lbl: lblMess , type: true)
      
        defaults.set(password, forKey: "password")
        
        
        
    }
    func showMessage(message:String , lbl : UILabel, type : Bool)  {
        lbl.text = message
        if type == true{
            lbl.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else {
            lbl.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
