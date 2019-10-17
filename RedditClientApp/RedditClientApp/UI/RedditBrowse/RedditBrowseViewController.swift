//
//  RedditBrowseViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditBrowseViewController as RedditBrowseView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditBrowseViewController : BaseViewController, RedditBrowseView, UITableViewDelegate, UITableViewDataSource, RedditVertFeedAction {
    
    /// presenter as RedditBrowsePresenter injected automatically to call implementations
    var presenter: RedditBrowsePresenter!
    
    /// injector as RedditBrowseInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditBrowseInjectorImplementation()
    
    @IBOutlet weak var redditBrowseBackImageView: UIImageView!
    
    @IBOutlet weak var redditBrowseTitleLabel: UILabel!
    
    @IBOutlet weak var redditBrowseTableView: UITableView!
    
    let cellChooser = CellChooser()
    
    var feedList : [FeedChildrenListing]?
    
    var isPopular = false
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let postHint = postHintFor(indexPath: indexPath), (postHint == "link" || postHint == "self"){
            return cellChooser.postLink(indexPath: indexPath, feedChildrenListing: feedList, tableView: tableView, redditFeed: self)
        }
        return cellChooser.postCard(indexPath: indexPath, feedChildrenListing: feedList, tableView: tableView, redditFeed: self)
    }
    
    func postHintFor(indexPath : IndexPath) -> String?{
        return feedList?[indexPath.row].data?.post_hint
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let postHint = postHintFor(indexPath: indexPath),
            (postHint == "self" || postHint == "link"){
            return 194
        }
        return 380
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = feedList?.count
        {
            return count
        }
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        redditBrowseTableView.register(UINib.init(nibName: "RedditPostCardTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditPostCardTableViewCell")
        redditBrowseTableView.register(UINib.init(nibName: "RedditPostLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditPostLinkTableViewCell")
        redditBrowseBackImageView.addTapGesture(selector: #selector(RedditBrowseViewController.backClicked), target: self)
        presenter.startAPI()
        redditBrowseTableView.delegate = self
        redditBrowseTableView.dataSource = self
    }
    
    @objc func backClicked()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// openAbout opens the about info (RedditAboutViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openAbout(index: Int, tag: Int) {
        let vc = UINavigation.vc(identifier: UINavigation.RedditAbout) as! RedditAboutViewController
        vc.author = feedList?[index].data?.author
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    /// openPreview opens the preview (RedditPreviewViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openPreview(index: Int, tag: Int) {
        let vc = UINavigation.vc(identifier: UINavigation.RedditPreview) as! RedditPreviewViewController
        if let list = feedList{
            vc.image = cellChooser.getLink(list:  list , index: index)
            vc.previewDate = list[index].data?.created_utc?.toDate().fromNow()
            vc.previewLabel = list[index].data?.subreddit_name_prefixed
            vc.user = list[index].data?.author
            vc.previewTitle = list[index].data?.title
            
            if let comments = list[index].data?.num_comments, let upvotes =  list[index].data?.ups{
                vc.comments = "\(comments)"
                vc.upvote = "\(upvotes)"
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    /// openComments opens the comments (RedditDetailCommentsViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openComments(index: Int, tag: Int) {
        if let child = feedList?[index], let subreddit = feedList?[index].data?.subreddit_name_prefixed, let id = feedList?[index].data?.id{
            moveToComments(sr: subreddit, feedChildListing: child , id: id)
        }
    }
    
    /// openSubreddit opens the subreddit details (RedditDetailsViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openSubreddit(index: Int, tag: Int) {
        if let subreddit = feedList?[index].data?.subreddit_name_prefixed{
            moveToDetails(sr: subreddit)
        }
    }

    /// moveToDetails navigate to RedditDetailsViewController with subreddit parameter
    ///
    /// - Parameter sr: as String the subreddit to get the details
    func moveToDetails(sr : String)
    {
        let vc = UINavigation.vc(identifier: UINavigation.RedditDetails) as! RedditDetailsViewController
        vc.sr = sr
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
 
    /// moveToComments navigate to RedditDetailCommentsViewController with subreddit , feedchildrenListing and id parameter
    ///
    /// - Parameters:
    ///   - sr: as String the subreddit to get the details
    ///   - feedChildListing: as FeedChildrenListing the current child from the listing
    ///   - id: as String the id parameter to get the comments from
    func moveToComments(sr : String, feedChildListing : FeedChildrenListing, id : String)
    {
        let vc = UINavigation.vc(identifier: UINavigation.RedditComment) as! RedditDetailCommentsViewController
        vc.sr = sr
        vc.id = id
        vc.feedChildrenListing = feedChildListing
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    /// retrievedAllUpdateView updates the view after retrieving the listing for All
    ///
    /// - Parameter listing: as FeedListing for All
    func retrievedAllUpdateView(listing: FeedListing) {
        var text = ""
        if !isPopular
        {
            text = "All"
            feedList = listing.data?.children
        }
        DispatchQueue.main.async { [weak self] in
            self?.redditBrowseTableView.reloadData()
            self?.redditBrowseTitleLabel.text = text
        }
    }
    
    /// retrievedPopularUpdateView updates the view after retrieving the listing for Popular
    ///
    /// - Parameter listing: as FeedListing for All
    func retrievedPopularUpdateView(listing: FeedListing?) {
        var text = ""
        if isPopular
        {
            text = "Popular"
            feedList = listing?.data?.children
        }
        DispatchQueue.main.async { [weak self] in
            self?.redditBrowseTableView.reloadData()
            self?.redditBrowseTitleLabel.text = text
        }
    }
}
