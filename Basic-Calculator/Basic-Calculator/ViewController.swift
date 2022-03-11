//
//  ViewController.swift
//  Basic-Calculator
//
//  Created by Furkan Sarı on 11.03.2022.
//

import UIKit

class ViewController: UIViewController {
    var result:Double=0
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    var n1 = 0
    var n2 = 0
    
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sumFunc(_ sender: Any) {
        n1=Int(number1.text ?? "") ?? 0
        n2=Int(number2.text ?? "") ?? 0
        result = Double(n1+n2)
        resultLabel.text!=String("Result : \(result)")
        
    }
    
    @IBAction func minusFunc(_ sender: Any) {
        n1=Int(number1.text ?? "") ?? 0
        n2=Int(number2.text ?? "") ?? 0
        result = Double(n1-n2)
        resultLabel.text!=String("Result : \(result)")
    }
    
    @IBAction func divideFunc(_ sender: Any) {
        n1=Int(number1.text ?? "") ?? 0
        n2=Int(number2.text ?? "") ?? 0
        result = Double(n1/n2)
        resultLabel.text!=String("Result : \(result)")
    }
    
    @IBAction func multiplerFunc(_ sender: Any) {
        n1=Int(number1.text ?? "") ?? 0
        n2=Int(number2.text ?? "") ?? 0
        result = Double(n1*n2)
        resultLabel.text!=String("Result : \(result)")
    }
}

