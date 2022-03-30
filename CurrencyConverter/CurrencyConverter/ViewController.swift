//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Furkan Sarı on 30.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadCurrency: UILabel!
    @IBOutlet weak var usdCurrency: UILabel!
    @IBOutlet weak var tryCurrency: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getCurrency(_ sender: Any) {
        
        //Request
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=8a17b571c526fa048af0b9901100f0f5&format=1")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { urlData, urlResponse, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                //Response Data
                if urlData != nil{
                    
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: urlData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResult["rates"] as? [String : Any]{
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadCurrency.text = "CAD : \(cad)"
                                }
                                
                                if let tryLiras = rates["TRY"] as? Double{
                                    self.tryCurrency.text = "TRY : \(tryLiras)"
                                }
                                
                                if let usd = rates["USD"] as? Double{
                                    self.usdCurrency.text = "USD : \(usd)"
                                }
                                
                            }
                        }
                    }catch{
                        print("Json Error")
                    }
                    
                    
                    
                }
            }
            
        }
        task.resume()
    }
}

