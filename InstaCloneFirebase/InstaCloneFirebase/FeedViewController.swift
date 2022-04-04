//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by Furkan Sarı on 1.04.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var mails = [String]()
    var comments = [String]()
    var likes = [Int]()
    var images = [String]()
    var documentIDs = [String]()
    
    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.rowHeight = 320
        getData()
        print(mails.count)
        // Do any additional setup after loading the view.
    }
    func getData(){
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").addSnapshotListener { postData, error in
            if error != nil {
                print("Hata")
            }else{
                if postData?.isEmpty != true && postData != nil {
                    self.mails.removeAll(keepingCapacity: false)
                    self.comments.removeAll(keepingCapacity: false)
                    self.likes.removeAll(keepingCapacity: false)
                    self.images.removeAll(keepingCapacity: false)
                    
                    for document in postData!.documents{
                        let documentID = document.documentID
                        self.documentIDs.append(documentID)
                        if let mail = document.get("postedBy") as? String{
                            self.mails.append(mail)
                            
                        }
                        if let comment = document.get("postComment") as? String{
                            self.comments.append(comment)
                            
                        }
                        if let like = document.get("likes") as? Int{
                            self.likes.append(like)
                            
                        }
                        if let image = document.get("imageUrl") as? String{
                            self.images.append(image)
                            
                        }
                        
                    }
                    self.feedTableView.reloadData()
                }
            }
            
        }
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.postMailText.text = mails[indexPath.row]
        cell.commentText.text = comments[indexPath.row]
        cell.likeCountText.text = String(likes[indexPath.row])
        cell.postImage.sd_setImage(with: URL(string: self.images[indexPath.row]))
        cell.documentIDLabel.text = documentIDs[indexPath.row]
        
        return cell
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
