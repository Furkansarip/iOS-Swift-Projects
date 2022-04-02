//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Furkan Sarı on 3.04.2022.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postMailText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var likeCountText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButton(_ sender: Any) {
    }
}
