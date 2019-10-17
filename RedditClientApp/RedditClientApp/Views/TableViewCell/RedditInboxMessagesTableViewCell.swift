//
//  RedditInboxMessagesTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditInboxMessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var redditInboxUserNameLabel: UILabel!
    
    @IBOutlet weak var redditInboxDateLabel: UILabel!
    
    @IBOutlet weak var redditInboxMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
