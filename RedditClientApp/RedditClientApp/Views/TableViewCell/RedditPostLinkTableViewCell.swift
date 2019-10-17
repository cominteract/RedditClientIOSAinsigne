//
//  RedditBestPostTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

// TODO UNUSED
protocol AnimateLeftToRightCell : class{
    func animateLtoR(view : UIView)
}
class RedditPostLinkTableViewCell: UITableViewCell {

    @IBOutlet weak var redditBestPostImageView: UIImageView!
    
    @IBOutlet weak var redditBestPostUpvoteImageView: UIImageView!
    
    @IBOutlet weak var redditBestPostDownvoteImageView: UIImageView!
    
    @IBOutlet weak var redditBestPostDisplayImageView: UIImageView!
    
    @IBOutlet weak var redditBestPostShareImageView: UIImageView!
    
    @IBOutlet weak var redditBestPostLabel: UILabel!
    
    @IBOutlet weak var redditBestPostTitleLabel: UILabel!
    
    @IBOutlet weak var redditBestPostDateLabel: UILabel!
    
    @IBOutlet weak var redditBestPostUpvoteLabel: UILabel!
    
    @IBOutlet weak var redditBestPostCommentLabel: UILabel!
    
    @IBOutlet weak var redditBestPostShareLabel: UILabel!
    
    @IBOutlet weak var redditBestPostAwardLabel: UILabel!
    
    @IBOutlet weak var redditBestPostCommentView: UIView!
    
    @IBOutlet weak var redditBestPostCommentImageView: UIImageView!
    
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
        // Initialization code
        redditBestPostImageView.addTapGesture(selector: #selector(RedditPostLinkTableViewCell.openPreview), target: self)
        redditBestPostCommentLabel.addTapGesture(selector: #selector(RedditPostLinkTableViewCell.openComments), target: self)
        redditBestPostCommentView.addTapGesture(selector: #selector(RedditPostLinkTableViewCell.openComments), target: self)
        redditBestPostLabel.addTapGesture(selector: #selector(RedditPostLinkTableViewCell.openSubreddit), target: self)
        redditBestPostCommentImageView.addTapGesture(selector: #selector(RedditPostLinkTableViewCell.openComments), target: self)
        redditBestPostTitleLabel.addTapGesture(selector: #selector(RedditPostLinkTableViewCell.openAbout), target: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
