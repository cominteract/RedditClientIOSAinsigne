//
//  RedditInboxActivityTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditInboxActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var redditInboxActivityLabel: UILabel!
    
    @IBOutlet weak var redditInboxActivityDateLabel: UILabel!
    
    @IBOutlet weak var redditInboxActivityCategoryLabel: UILabel!
    
    
    @IBOutlet weak var redditInboxActivityDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
