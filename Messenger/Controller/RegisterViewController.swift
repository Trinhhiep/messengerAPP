//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Admin on 08/05/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtfUsername: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var txtfConfirm: UITextField!
    @IBOutlet weak var txtfDisplayName: UITextField!
    @IBOutlet weak var txtfPhoneNumber: UITextField!
    
    
    @IBOutlet weak var lblDisplaynameMessage: UILabel!
    @IBOutlet weak var lblPhoneNumberMessage: UILabel!
    @IBOutlet weak var lblConfirmMessage: UILabel!
    @IBOutlet weak var lblPasswordMessage: UILabel!
    @IBOutlet weak var lblUsernameMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtfPassword.isSecureTextEntry = true
        txtfConfirm.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
  
   
    @IBAction func txtfUsernameTextChanged(_ sender: Any) {
        guard let username = txtfUsername.text else {
            return
        }
        let path = "INFOPUBLIC/"+username
        FirebaseSingleton.instance?.fetchOneSingleEvent(path: path, completionHandler: { [self](data : InfoPublic? , error: Error?) in
            guard data != nil else {
                lblUsernameMessage.textAlignment = . left
                self.showMessage(message: "Username can be used!", lbl: self.lblUsernameMessage, type: true)
                return
            }
            
                lblUsernameMessage.textAlignment = . left
            self.showMessage(message: "Username is exist!", lbl: self.lblUsernameMessage, type: false)
        })
    }
    
    @IBAction func txtfPassword(_ sender: Any) {
        guard txtfPassword.text!.count >= 8  else {
            self.showMessage(message: "Password length greater than 8 characters!", lbl: lblPasswordMessage, type: false)
            return
        }
        self.showMessage(message: "Valid password!", lbl: lblPasswordMessage, type: true)
    }
    
    @IBAction func txtfConfirm(_ sender: Any) {
        guard txtfPassword.text != nil else {
            self.showMessage(message: "Invalid password!", lbl: lblPasswordMessage, type: false)
            return
        }
        guard txtfConfirm.text == txtfPassword.text else {
            self.showMessage(message: "Invalid confirm password!", lbl: lblConfirmMessage, type: false)
            return
        }
        self.showMessage(message: "Password match!", lbl: lblConfirmMessage, type: true)
    
    }
    
    @IBAction func txtfPhoneNumber(_ sender: Any) {
        guard  txtfPhoneNumber.text?.isEmpty == false else {
            self.showMessage(message: "Phonenumber cannot be empty!", lbl: lblPhoneNumberMessage, type: false)
            return
        }
    }
    
    @IBAction func txtfDisplayname(_ sender: Any) {
        guard  txtfDisplayName.text?.isEmpty == false else {
            self.showMessage(message: "Displayname cannot be empty!", lbl: lblDisplaynameMessage, type: false)
            return
        }
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        guard txtfPassword.text?.isEmpty == false   else {
            return
        }
        guard txtfConfirm.text?.isEmpty == false   else {
            return
        }
        guard txtfDisplayName.text?.isEmpty == false   else {
            self.showMessage(message: "Displayname cannot be empty!", lbl: lblDisplaynameMessage, type: false)
        
            return
        }
        guard txtfPhoneNumber.text?.isEmpty == false   else {
            self.showMessage(message: "Phone number cannot be empty!", lbl: lblPhoneNumberMessage, type: false)

            return
        }
        guard  txtfPassword.text == txtfConfirm.text else {
            return
        }
        guard let username = txtfUsername.text else {
            return
        }
        
        let path = "INFOPUBLIC/"+username
        FirebaseSingleton.instance?.fetchOneSingleEvent(path: path, completionHandler: { [self](data : InfoPublic? , error: Error?) in
            guard data == nil else {// da ton tai username
                lblUsernameMessage.textAlignment = . center
                self.showMessage(message: "Register failure!", lbl: lblUsernameMessage , type: false)
                
                return
            }
            let username = txtfUsername.text
            let password = txtfPassword.text
            let displayName = txtfDisplayName.text
            let phoneNumber = txtfPhoneNumber.text
            let user = User(username!, password!, displayName!, phoneNumber!)
            FirebaseSingleton.instance?.insertUser(user: user)
            resetLable()
            lblUsernameMessage.textAlignment = . center
            self.showMessage(message: "Register successfull!", lbl: lblUsernameMessage , type: true)
            
        })
        
    }
    func resetLable() {
        lblUsernameMessage.text = ""
        lblPasswordMessage.text = ""
        lblConfirmMessage.text = ""
        lblDisplaynameMessage.text = ""
        lblPhoneNumberMessage.text = ""
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
}
