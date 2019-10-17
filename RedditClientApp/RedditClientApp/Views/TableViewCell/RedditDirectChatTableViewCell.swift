//
//  RedditDirectChatTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditDirectChatTableViewCell: UITableViewCell {

    @IBOutlet weak var redditDirectChatImageView: UIImageView!
    
    @IBOutlet weak var redditDirectChatUserLabel: UILabel!
    
    @IBOutlet weak var redditDirectChatMessageLabel: UILabel!
    
    @IBOutlet weak var redditDirectChatDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
