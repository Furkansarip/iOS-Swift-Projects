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
    override func viewDidLoad() {
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
