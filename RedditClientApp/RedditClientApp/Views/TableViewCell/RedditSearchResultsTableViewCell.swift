//
//  RedditSearchResultsTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditSearchResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var redditSearchResultsLabel: UILabel!
    
    @IBOutlet weak var redditSearchResultsTopicLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
