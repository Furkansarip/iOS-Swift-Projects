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
    @IBOutlet weak var postText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addImageView.isUserInteractionEnabled=true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(uploadImage))
        addImageView.addGestureRecognizer(recognizer)
        
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        let imageId = UUID().uuidString
        let storage = Storage.storage()
        let storangeRef = storage.reference()
        
        let mediaFolder = storangeRef.child("media")
        
        
        if let data = addImageView.image?.jpegData(compressionQuality: 0.5){
        let imageRef = mediaFolder.child(imageId)
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    print(error?.localizedDescription)
                }else{
                    imageRef.downloadURL { url, error in
                        let imageUrl = url?.absoluteString
                        print(imageUrl)
                        
                        //Database
                        let firestoreDatabase = Firestore.firestore()
                        var firestoreRef : DocumentReference? = nil
                        let Posts = ["imageUrl":imageUrl,"postedBy":Auth.auth().currentUser?.email,"postComment":self.postText.text,"date":FieldValue.serverTimestamp(),"likes":0] as! [String:Any]
                        firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: Posts, completion: { error in
                            if error != nil{
                                self.makeAlert(title: "Post Error", message: "We have a Problem!")
                            }
                            else {
                                self.addImageView.image = UIImage(systemName: "camera.circle.fill")
                                self.postText.text = ""
                                self.tabBarController?.selectedIndex = 0
                            }
                        })
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
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
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
