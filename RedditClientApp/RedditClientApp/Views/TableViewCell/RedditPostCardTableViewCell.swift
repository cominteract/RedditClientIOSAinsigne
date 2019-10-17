//
//  RedditPopularTableViewCell.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit


///  RedditVertFeedAction protocol for opening from different entrypoints from a post
protocol RedditVertFeedAction : class{
    
    /// openAbout opens the about info modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openAbout(index : Int, tag : Int)
    /// openSubreddit opens the subreddit details modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openSubreddit(index : Int , tag : Int)
    
    /// openPreview opens the preview modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openPreview(index : Int , tag : Int)
    
    /// openComments opens the comments modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openComments(index : Int , tag : Int)
}

class RedditPostCardTableViewCell : UITableViewCell {

    @IBOutlet weak var redditPopularPostHintLabel: UILabel!
    
    @IBOutlet weak var redditPopularVertImageHeight: NSLayoutConstraint!
    
    @IBAction func joinClicked(_ sender: Any) {
    }
    
    
    @IBAction func moreClicked(_ sender: Any) {
    }
    
    @IBOutlet weak var redditPopularImageView: UIImageView!
    
    @IBOutlet weak var redditPopularLabel: UILabel!
    
    @IBOutlet weak var redditPopularUserLabel: UILabel!
    
    @IBOutlet weak var redditPopularAwardLabel: UILabel!
    
    @IBOutlet weak var redditPopularTitleLabel: UILabel!
    
    @IBOutlet weak var redditPopularDateLabel: UILabel!
    
    @IBOutlet weak var redditPopularJoinButton: UIButton!
    
    @IBOutlet weak var redditPopularMoreButton: UIButton!
    
    @IBOutlet weak var redditPopularDisplayImageView: UIImageView!
    
    @IBOutlet weak var redditPopularUpvoteImageView: UIImageView!
    
    @IBOutlet weak var redditPopularUpvoteLabel: UILabel!
    
    @IBOutlet weak var redditPopularDownvoteImageView: UIImageView!
    
    @IBOutlet weak var redditPopularShareImageView: UIImageView!
    
    @IBOutlet weak var redditPopularShareLabel: UILabel!
    
    @IBOutlet weak var redditPopularCommentImageView: UIImageView!
    
    @IBOutlet weak var redditPopularCommentLabel: UILabel!
    
    @IBOutlet weak var redditPopularCommentView: UIView!
    
    var index = 0
    
    var indexPath : IndexPath?
    
    weak var delegate : RedditVertFeedAction?
    
    /// openAbout opens the about info modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openAbout()
    {
        delegate?.openAbout(index: index, tag: 0)
    }
    
    // openSubreddit opens the subreddit details modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openSubreddit()
    {
        delegate?.openSubreddit(index: index, tag: 0)
    }
    
    /// openPreview opens the preview modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openPreview()
    {
        delegate?.openPreview(index: index, tag: 0)
    }
    
    /// openComments opens the comments modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    @objc func openComments()
    {
        delegate?.openComments(index: index, tag: 0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        redditPopularUserLabel.addTapGesture(selector: #selector(RedditPostCardTableViewCell.openAbout), target: self)
        redditPopularLabel.addTapGesture(selector: #selector(RedditPostCardTableViewCell.openSubreddit), target: self)
        redditPopularDisplayImageView.addTapGesture(selector: #selector(RedditPostCardTableViewCell.openPreview), target: self)
        redditPopularCommentImageView.addTapGesture(selector: #selector(RedditPostCardTableViewCell.openComments), target: self)
        redditPopularCommentLabel.addTapGesture(selector: #selector(RedditPostCardTableViewCell.openComments), target: self)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
