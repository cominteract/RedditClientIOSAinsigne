//
//  RedditCommentTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var redditCommentUserLabel: UILabel!
    
    @IBOutlet weak var redditCommentDateLabel: UILabel!
    
    @IBOutlet weak var redditCommentLabel: UILabel!
    
    @IBOutlet weak var redditCommentUpvoteLabel: UILabel!
    
    @IBOutlet weak var redditCommentUpvoteImageView: UIImageView!
    
    @IBOutlet weak var redditCommentDownvoteImageView: UIImageView!
    
    @IBOutlet weak var redditCommentShareImageView: UIImageView!
    
    
    @IBAction func moreClicked(_ sender: Any) {
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
