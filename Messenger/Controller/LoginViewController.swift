//
//  LoginViewController.swift
//  Messenger
//
//  Created by Admin on 16/05/2021.
//

import UIKit

class LoginViewController: UIViewController {
    static   var  infoPublic : InfoPublic?
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtfUsername: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtfPassword.isSecureTextEntry = true
        
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "username")
        let password = defaults.string(forKey: "password")
        guard username != nil && password != nil else {
            return
        }
        logIn(username: username!, password: password!)
        
    }
    
    @IBAction func txtfUsernameTextChange(_ sender: Any) {
        self.lblError.text = ""
    }
    @IBAction func txtfPasswordTextChange(_ sender: Any) {
        self.lblError.text = ""
    }
    
    func logIn(username : String, password: String) {
        let path = "private/"+username
        
        FirebaseSingleton.instance?.fetchOneSingleEvent(path: path, completionHandler: {(data : User? , error : Error?) in
            guard let data = data else {
                self.lblError.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                self.lblError.text = "Username or password is wrong!"
                return
            }
            if data.username == username && data.password == password{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let mainTabBarController = storyboard.instantiateViewController(identifier: "TABBAR")
                       mainTabBarController.modalPresentationStyle = .fullScreen

                       self.present(mainTabBarController, animated: true, completion: nil)
                
                
                let defaults = UserDefaults.standard
                defaults.set(data.username, forKey: "username")
                defaults.set(data.password, forKey: "password")
                
                print("login successs")
                


            }
            
        })
    }

    @IBAction func btnLogin(_ sender: Any) {
        guard txtfUsername.text != "" && txtfPassword.text != "" else {
            return
        }
        let username = txtfUsername.text
        let password = txtfPassword.text
       
        logIn(username: username!, password: password!)
    }
    @IBAction func btnForgotPassword(_ sender: Any) {
    }
    @IBAction func btnRegister(_ sender: Any) {
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
