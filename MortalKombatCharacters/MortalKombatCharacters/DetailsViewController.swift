//
//  DetailsViewController.swift
//  SimpsonBook
//
//  Created by Furkan Sarı on 22.03.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    var mkCharacters : Characters?
    var name : String = ""

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clanLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text=mkCharacters?.name
        clanLabel.text=mkCharacters?.clan
        imageView.image=mkCharacters?.image
        
        
        // Do any additional setup after loading the view.
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
