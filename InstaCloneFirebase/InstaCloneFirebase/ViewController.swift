//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Furkan Sarı on 1.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUp(_ sender: Any) {
    }
    
    @IBAction func signIn(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
}

