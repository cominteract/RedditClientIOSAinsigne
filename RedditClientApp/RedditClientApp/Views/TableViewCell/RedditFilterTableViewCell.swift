//
//  RedditFilterTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var redditFilterLabel: UILabel!
    
    @IBOutlet weak var redditFilterImageView: UIImageView!
    

    @IBOutlet weak var redditFilterDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
