//
//  AddItemViewController.swift
//  ArtBook
//
//  Created by Furkan Sarı on 23.03.2022.
//

import UIKit
import CoreData
class AddItemViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var itemPaintings=""
    var itemId : UUID?
    override func viewDidLoad() {
        if itemPaintings != ""{
            saveButton.isHidden=true
            artistField
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let stringId=itemId?.uuidString
            fetchRequest.predicate=NSPredicate(format: "id = %@", stringId!)
            do{
                let results = try context.fetch(fetchRequest)
                
                for result in results as! [NSManagedObject]{
                    if let name = result.value(forKey: "name") as? String{
                        nameField.text=name
                    }
                    if let artist = result.value(forKey: "artist") as? String{
                        artistField.text=artist
                    }
                    if let year = result.value(forKey: "year") as? Int{
                        yearField.text = String(year)
                    }
                    if let imageData = result.value(forKey: "image") as? Data{
                        let image=UIImage(data: imageData)
                        addImageView.image=image
                    }
                    
                }
            }catch{
                
            }
            fetchRequest.returnsObjectsAsFaults=false
        }else {
            saveButton.isHidden=false
            saveButton.isEnabled=false
        }
        
        super.viewDidLoad()
        
        
        //Recognizers
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        addImageView.isUserInteractionEnabled=true
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(addImages))
        addImageView.addGestureRecognizer(imageTap)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        newPainting.setValue(artistField.text!, forKey: "artist")
        newPainting.setValue(nameField.text!, forKey: "name")
        if let year = Int(yearField.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = addImageView.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        do{
            
            try context.save()
            print("başarılı")
            
        }catch{
            print("Hata")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
        
    }
    
    @objc func addImages(){
        let picker=UIImagePickerController()
        picker.delegate=self
        picker.sourceType = .photoLibrary
        picker.allowsEditing=true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        addImageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled=true
        self.dismiss(animated: true, completion: nil)
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
