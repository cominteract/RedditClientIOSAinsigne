//
//  RedditDetailHeadeTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditDetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var redditDetailHeaderDescLabel: UILabel!
    
    @IBOutlet weak var redditDetailHeaderImageView: UIImageView!
    
    @IBOutlet weak var redditDetailHeaderCoverImageView: UIImageView!
    
    @IBOutlet weak var redditDetailHeaderLabel: UILabel!
    
    @IBOutlet weak var redditDetailHeaderOnline: UILabel!
    
    @IBOutlet weak var redditDetailHeaderMemberLabel: UILabel!
    
    @IBOutlet weak var redditDetailHeaderTabBar: UITabBar!
    
    
    @IBOutlet weak var conventView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
