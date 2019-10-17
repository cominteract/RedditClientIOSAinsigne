//
//  RedditNewsTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var redditNewsStoryLabel: UILabel!
    
    @IBOutlet weak var redditNewsLabel: UILabel!
    
    @IBOutlet weak var redditNewsDateLabel: UILabel!
    
    @IBOutlet weak var redditNewsAwardLabel: UILabel!
    
    @IBOutlet weak var redditNewsTitleLabel: UILabel!
    
    @IBOutlet weak var redditNewsDisplayImageView: UIImageView!
    
    @IBOutlet weak var redditNewsUpvoteImageView: UIImageView!
    
    @IBOutlet weak var redditNewsUpvoteLabel: UILabel!
    
    @IBOutlet weak var redditNewsDownvoteImageView: UIImageView!
    
    weak var delegate : RedditVertFeedAction?
    
    @IBOutlet weak var redditNewsShareImageView: UIImageView!
    
    @IBOutlet weak var redditNewsShareLabel: UILabel!
    
    @IBOutlet weak var redditNewsSourceLabel: UILabel!
    
    @IBOutlet weak var redditNewsCommentImageView: UIImageView!
    
    @IBOutlet weak var redditNewsCommentView: UIView!
    
    @IBOutlet weak var redditNewsCommentLabel: UILabel!
    
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        redditNewsDisplayImageView.addTapGesture(selector: #selector(RedditNewsTableViewCell.openPreview), target: self)
        redditNewsCommentView.addTapGesture(selector: #selector(RedditNewsTableViewCell.openComments), target: self)
        
        redditNewsCommentLabel.addTapGesture(selector: #selector(RedditNewsTableViewCell.openComments), target: self)
        redditNewsStoryLabel.addTapGesture(selector: #selector(RedditNewsTableViewCell.openSubreddit), target: self)
        redditNewsCommentImageView.addTapGesture(selector: #selector(RedditNewsTableViewCell.openComments), target: self)
        redditNewsTitleLabel.addTapGesture(selector: #selector(RedditNewsTableViewCell.openAbout), target: self)
    }
    
    /// openAbout opens the about info modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openAbout()
    {
        delegate?.openAbout(index: index, tag: 2)
    }
    
    /// openSubreddit opens the subreddit details modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openSubreddit()
    {
        delegate?.openSubreddit(index: index, tag: 2)
    }
    
    /// openPreview opens the preview modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openPreview()
    {
        delegate?.openPreview(index: index, tag: 2)
    }
    
    /// openComments opens the comments modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openComments()
    {
        delegate?.openComments(index: index, tag: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
