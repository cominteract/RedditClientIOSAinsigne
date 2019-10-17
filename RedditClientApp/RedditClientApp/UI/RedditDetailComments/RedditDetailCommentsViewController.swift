//
//  RedditDetailCommentsViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditDetailCommentsViewController as RedditDetailCommentsView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditDetailCommentsViewController : BaseViewController, RedditDetailCommentsView, UITableViewDataSource, UITableViewDelegate {
    
    /// presenter as RedditDetailCommentsPresenter injected automatically to call implementations
    var presenter: RedditDetailCommentsPresenter!
    
    /// injector as RedditDetailCommentsInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditDetailCommentsInjectorImplementation()
    
    @IBOutlet weak var tableView: UITableView!
    
    var feedChildrenListing : FeedChildrenListing?
    
    var sr : String?
    
    var id : String?
    
    var comments : [Comments]?
    
    var subreddit : Subreddit?
    
    var cellChooser = CellChooser()
    
    var indexes = [(Int,Int, Int)]()
    
    var commentList = [CommentsChildren]()
    
    @IBOutlet weak var redditDetailCommentBackImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        self.tableView.register(UINib.init(nibName: "RedditHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditHomeTableViewCell")
        self.tableView.register(UINib.init(nibName: "RedditCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditCommentTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        if let sr = sr, let id = id{
            presenter.startAPI(sr: sr, id: id)
            redditDetailCommentSearchView.text = sr
        }
        redditDetailCommentBackImageView.addTapGesture(selector: #selector(RedditDetailCommentsViewController.closeClicked), target: self)
        
    }
    
    /// getAllCommentCount populates the comment list
    func getAllCommentCount()
    {
        if let main = comments
        {
            for i in 0..<main.count
            {
                if let comments = main[i].data?.children
                {
                    for y in 0..<comments.count
                    {
                        if y > 0
                        {
                            commentList.append(comments[y])
                        }
                        if let replies = comments[y].data?.replies?.data?.children
                        {
                            for reply in replies
                            {
                                commentList.append(reply)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func closeClicked()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let subreddit = feedChildrenListing
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedditHomeTableViewCell") as! RedditHomeTableViewCell
            cell.redditHomeLabel.text = subreddit.data?.subreddit_name_prefixed
            cell.redditHomeTitleLabel.text = subreddit.data?.title
            cell.redditHomeDateLabel.text = subreddit.data?.created_utc?.toDate().fromNow()
            cell.redditHomeUserLabel.text = subreddit.data?.author
            if let award = subreddit.data?.total_awards_received
            {
                cell.redditHomeAwardLabel.text = "\(award)"
            }
            if let comment = subreddit.data?.num_comments
            {
                cell.redditHomeCommentLabel.text = "\(comment)"
            }
            if let upvote = subreddit.data?.ups
            {
                cell.redditHomeUpvoteLabel.text = "\(upvote)"
                if upvote > 1000
                {
                    let up = upvote/1000
                    cell.redditHomeUpvoteLabel.text = "\(up)k"
                }
            }
            let link = cellChooser.getLink(child: subreddit)
            cell.redditHomeImageView.downloadedFrom(link: link)
            cell.redditHomePostImageView.downloadedFrom(link: link)
            return cell
        }
        else if indexPath.row > 0, indexPath.row <= commentList.count
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedditCommentTableViewCell") as! RedditCommentTableViewCell
            cell.redditCommentLabel.text = commentList[indexPath.row - 1].data?.body
            cell.redditCommentDateLabel.text = commentList[indexPath.row - 1].data?.created_utc?.toDate().fromNow()
            cell.redditCommentUserLabel.text = commentList[indexPath.row - 1].data?.author
            if let upvote = commentList[indexPath.row - 1].data?.ups
            {
                cell.redditCommentUpvoteLabel.text = "\(upvote)"
                if upvote > 1000
                {
                    let up = upvote/1000
                    cell.redditCommentUpvoteLabel.text = "\(up)k"
                }
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditCommentTableViewCell") as! RedditCommentTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if feedChildrenListing != nil
        {
            count = count + 1
        }
        count = count + commentList.count
        return count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
 
    /// retrievedCommentAboutSubreddit after retrieving the Subreddit info update the view
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedCommentAboutSubredditUpdateView(subreddit: Subreddit) {
        self.subreddit = subreddit
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var redditDetailCommentSearchView: UISearchBar!
    /// retrievedCommentPostsUpdateView after retrieving the listing for post comments update the view
    ///
    /// - Parameter listing: as [Comments] for the comment posts
    func retrievedCommentPostsUpdateView(listing: [Comments]) {
        self.comments = listing
        getAllCommentCount()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
