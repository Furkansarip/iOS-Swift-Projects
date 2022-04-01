//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Furkan Sarı on 1.04.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var addImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addImageView.isUserInteractionEnabled=true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(uploadImage))
        addImageView.addGestureRecognizer(recognizer)
        
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        
        let storage = Storage.storage()
        let storangeRef = storage.reference()
        
        let mediaFolder = storangeRef.child("media")
        
        if let data = addImageView.image?.jpegData(compressionQuality: 0.5){
        let imageRef = mediaFolder.child("image.jpg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    print(error?.localizedDescription)
                }else{
                    imageRef.downloadURL { url, error in
                        let imageUrl = url?.absoluteString
                        print(imageUrl)
                    }
                }
            }
            
        }
    }
    @objc func uploadImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
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
