//
//  RedditChatRoomTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditChatRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var redditChatRoomImageView: UIImageView!
    
    @IBOutlet weak var redditChatRoomLabel: UILabel!

    @IBOutlet weak var redditChatRoomTitleLabel: UILabel!
    
    @IBOutlet weak var redditChatRoomDescLabel: UILabel!
    
    @IBOutlet weak var redditMembersLabel: UILabel!
    
    @IBAction func viewRoomClicked(_ sender: Any) {
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
