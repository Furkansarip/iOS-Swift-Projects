//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Furkan Sarı on 22.03.2022.
//

import UIKit



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var mortalKombat = [Characters]()
    var choosenCharacter : Characters?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        // Do any additional setup after loading the view.
        let scorpion = Characters(initName: "Hanzo Hasashi", initClan: "Shirai Ryu", initImage: UIImage(named: "scorpion")!)
        let subzero = Characters(initName: "Bi-Han", initClan: "Kuai Liang", initImage: UIImage(named: "subzero")!)
        let kitana = Characters(initName: "Kitana", initClan: "Kuai Liang", initImage: UIImage(named: "kitana")!)
        
        mortalKombat.append(scorpion)
        mortalKombat.append(subzero)
        mortalKombat.append(kitana)
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text=mortalKombat[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mortalKombat.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenCharacter = mortalKombat[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.mkCharacters=choosenCharacter
        }
    }
    

}

