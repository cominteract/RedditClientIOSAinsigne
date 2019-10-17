//
//  RedditSearchTrendingTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditSearchTrendingTableViewCell: UITableViewCell {

    @IBOutlet weak var redditSearchTrendingLabel: UILabel!
    
    @IBOutlet weak var redditSearchTrendingDescLabel: UILabel!
    
    @IBOutlet weak var redditSearchTrendingImageView: UIImageView!
    
    @IBOutlet weak var redditSearchTrendingTitleLabel: UILabel!
    
    @IBOutlet weak var redditSearchTrendingDisplayImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
