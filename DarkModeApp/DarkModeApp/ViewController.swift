//
//  ViewController.swift
//  DarkModeApp
//
//  Created by Furkan Sarı on 31.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
            let userInterfaceStyle = traitCollection.userInterfaceStyle
                  
                  if userInterfaceStyle == .dark {
                      changeButton.tintColor = UIColor.white
                  } else {
                      changeButton.tintColor = UIColor.blue
                  }
                  
        }
        
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            let userInterfaceStyle = traitCollection.userInterfaceStyle
                        
                        if userInterfaceStyle == .dark {
                            changeButton.tintColor = UIColor.white
                        } else {
                            changeButton.tintColor = UIColor.blue
                        }
        }
}

