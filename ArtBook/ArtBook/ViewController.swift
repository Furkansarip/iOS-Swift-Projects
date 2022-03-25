//
//  ViewController.swift
//  ArtBook
//
//  Created by Furkan Sarı on 23.03.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var nameArray=[String]()
    var idArray=[UUID]()
    var mainPaintings=""
    var mainId : UUID?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addItem))
        tableView.delegate=self
        tableView.dataSource=self
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc func getData(){
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        var appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults=false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    self.nameArray.append(name)
                }
                if let id=result.value(forKey: "id") as? UUID {
                    idArray.append(id)
                }
                tableView.reloadData()
                
            }
        }catch{
            print("error")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text=nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    @objc func addItem(){
        mainPaintings=""
        performSegue(withIdentifier:"addItemPage" , sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context=appDelegate.persistentContainer.viewContext
            let fethRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let stringId=idArray[indexPath.row].uuidString
            fethRequest.predicate=NSPredicate(format: "id = %@", stringId)
            fethRequest.returnsObjectsAsFaults=false
            do{
                let results = try context.fetch(fethRequest)
                
                for result in results as! [NSManagedObject]{
                    if let id = result.value(forKey: "id") as? UUID{
                        if id == idArray[indexPath.row]{
                            context.delete(result)
                            nameArray.remove(at: indexPath.row)
                            idArray.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            self.tableView.reloadData()
                            
                            do{
                                try context.save()
                            }catch{
                                print("kayıt hatası")
                            }
                        }
                    }
                    
                }
            }catch{
                print("error")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainPaintings=nameArray[indexPath.row]
        mainId=idArray[indexPath.row]
        performSegue(withIdentifier: "addItemPage", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemPage" {
            let destination = segue.destination as! AddItemViewController
            destination.itemPaintings = mainPaintings
            destination.itemId = mainId
        }
    }


}

