//
//  RedditListTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit



class RedditListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var redditListImageView: UIImageView!
    
    @IBOutlet weak var redditListLabel: UILabel!
    
    @IBOutlet weak var redditLostYearLabel: UILabel!
    
    @IBOutlet weak var redditListKarmaLabel: UILabel!
    
    @IBOutlet weak var redditListDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
