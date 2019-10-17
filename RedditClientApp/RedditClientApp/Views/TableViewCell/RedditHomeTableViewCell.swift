//
//  RedditHomeTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var redditHomeImageView: UIImageView!
    
    
    @IBOutlet weak var redditHomeLabel: UILabel!
    
    @IBOutlet weak var redditHomeUserLabel: UILabel!
    
    @IBOutlet weak var redditHomeDateLabel: UILabel!
    
    @IBOutlet weak var redditHomeAwardLabel: UILabel!
    
    
    @IBOutlet weak var redditHomeTitleLabel: UILabel!
    
    
    @IBOutlet weak var redditHomePostImageView: UIImageView!
    
    
    
    @IBOutlet weak var redditHomeUpvoteImageView: UIImageView!
    
    
    @IBOutlet weak var redditHomeUpvoteLabel: UILabel!
    
    @IBOutlet weak var redditHomeDownvoteImageView: UIImageView!
    
    @IBOutlet weak var redditHomeCommentImageView: UIImageView!
    
    @IBOutlet weak var redditHomeCommentLabel: UILabel!
    
    
    @IBOutlet weak var redditHomeShareImageView: UIImageView!
    
    @IBOutlet weak var redditHomeShareLabel: UILabel!
    
    @IBOutlet weak var redditHomeCommentView: UIView!
    
    weak var delegate : RedditVertFeedAction?
    
    var index = 0
   
    /// openAbout opens the about info modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openAbout()
    {
        delegate?.openAbout(index: index, tag: 1)
    }
    
    /// openSubreddit opens the subreddit details modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openSubreddit()
    {
        delegate?.openSubreddit(index: index, tag: 1)
    }
    
    /// openPreview opens the preview modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openPreview()
    {
        delegate?.openPreview(index: index, tag: 1)
    }
    
    /// openComments opens the comments modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openComments()
    {
        delegate?.openComments(index: index, tag: 1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        redditHomePostImageView.addTapGesture(selector: #selector(RedditHomeTableViewCell.openPreview), target: self)
        redditHomeCommentView.addTapGesture(selector: #selector(RedditHomeTableViewCell.openComments), target: self)
        
        redditHomeCommentLabel.addTapGesture(selector: #selector(RedditHomeTableViewCell.openComments), target: self)
        redditHomeLabel.addTapGesture(selector: #selector(RedditHomeTableViewCell.openSubreddit), target: self)
        redditHomeCommentImageView.addTapGesture(selector: #selector(RedditHomeTableViewCell.openComments), target: self)
        redditHomeUserLabel.addTapGesture(selector: #selector(RedditHomeTableViewCell.openAbout), target: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
