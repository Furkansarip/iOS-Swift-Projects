//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Furkan Sarı on 1.04.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUp(_ sender: Any) {
        
        if mail.text != "" && password.text != ""{
            Auth.auth().createUser(withEmail: mail.text!, password: password.text!) { newAuthData, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else {
            makeAlert(title: "Error", message: "Username/Password Empty")
            
            
        }
       
    }
    
    @IBAction func signIn(_ sender: Any) {
        if mail.text != "" && password.text != "" {
            Auth.auth().signIn(withEmail: mail.text!, password: password.text!) { newLogin, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
                }
        }
        else {
            makeAlert(title: "Error", message: "Username/Password Empty")

            
        }
    }
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}

