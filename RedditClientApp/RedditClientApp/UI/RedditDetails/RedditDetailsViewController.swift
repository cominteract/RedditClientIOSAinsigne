
//
//  RedditDetailsViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

enum DetailListType{
    case Posts
    case About
    case Menu
}

/// RedditDetailsViewController as RedditDetailsView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditDetailsViewController : BaseViewController, RedditDetailsView, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, RedditVertFeedAction{
    
    /// presenter as RedditDetailsPresenter injected automatically to call implementations
    var presenter: RedditDetailsPresenter!
    
    /// injector as RedditDetailsInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditDetailsInjectorImplementation()
    
    var subDetails : Subreddit?
    
    var posts : [FeedChildrenListing]?
    
    var rules : Rules?
    
    var sr : String?
   
    @IBOutlet weak var redditDetailsSearchView: UISearchBar!
    
    @IBOutlet weak var redditBackImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate : AnimateLeftToRightCell?
    
    let cellChooser = CellChooser()
    
    var detailListType  = DetailListType.Posts
    
    var currentIndex = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let postcount = posts?.count, detailListType == DetailListType.Posts
        {
            return postcount + 1
        }
        if let rulecount = rules?.rules?.count, detailListType == DetailListType.About
        {
            return rulecount + 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1
        {
            return 340
        }
        else
        {
            if let postHint = posts?[indexPath.row].data?.post_hint,
                (postHint == "self" || postHint == "link"), detailListType == DetailListType.Posts
            {
                 return 194
            }
            else if detailListType == DetailListType.About
            {
                return 72
            }
            return 380
        }
    }
   
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.index(of : item), index == 0
        {
            if currentIndex != index
            {
                detailListType = DetailListType.Posts
                currentIndex = index
                tableView.reloadData()
            }
        }
        else if let index = tabBar.items?.index(of : item), index == 1
        {
            if currentIndex != index
            {
                detailListType = DetailListType.About
                currentIndex = index
                tableView.reloadData()
            }
        }
        else if let index = tabBar.items?.index(of : item), index == 2
        {
            if currentIndex != index
            {
                detailListType = DetailListType.Menu
                currentIndex = index
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedditDetailHeaderTableViewCell") as! RedditDetailHeaderTableViewCell
            cell.redditDetailHeaderTabBar.delegate = self
            cell.redditDetailHeaderLabel.text = subDetails?.data?.display_name_prefixed
            
            if let link = subDetails?.data?.icon_img, let header = subDetails?.data?.banner_img, let subs = subDetails?.data?.subscribers, let online = subDetails?.data?.active_user_count, let desc = subDetails?.data?.public_description
            {
                cell.redditDetailHeaderImageView.downloadedFrom(link: link)
                cell.redditDetailHeaderCoverImageView.downloadedFrom(link: header)
                cell.redditDetailHeaderMemberLabel.text = "\(subs)"
                cell.redditDetailHeaderOnline.text = "\(online)"
                if online > 999
                {
                    let konline = online/1000
                    cell.redditDetailHeaderOnline.text = "\(konline)k"
                }
                cell.redditDetailHeaderOnline.text = "\(online)"
                cell.redditDetailHeaderDescLabel.text = desc
            }
            return cell
        }
        else
        {
            if let list = posts, detailListType == DetailListType.Posts
            {
                if let postHint = posts?[indexPath.row].data?.post_hint, (postHint == "link" || postHint == "self"){
                    return cellChooser.postLink(indexPath: indexPath, feedChildrenListing: list, tableView: tableView, redditFeed: self)
                }
                return cellChooser.postCard(indexPath: indexPath, feedChildrenListing: list, tableView: tableView, redditFeed: self)
            }
            if let list = rules , detailListType == DetailListType.About
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
                //UILineBreakModeWordWrap; or NSLineBreakByWordWrapping;
                if indexPath.row == 1{
                    cell.textLabel?.text = "RULES"
                }
                else{
                    cell.textLabel?.text = list.rules?[indexPath.row - 2].description
                }
                return cell
            }
            return tableView.dequeueReusableCell(withIdentifier: "RedditDetailHeaderTableViewCell") as! RedditDetailHeaderTableViewCell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        self.tableView.register(UINib.init(nibName: "RedditPostLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditPostLinkTableViewCell")
        self.tableView.register(UINib.init(nibName: "RedditDetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditDetailHeaderTableViewCell")
        self.tableView.register(UINib.init(nibName: "RedditPostCardTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditPostCardTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        redditBackImageView.addTapGesture(selector: #selector(RedditDetailsViewController.backClicked), target: self)
        if let sr = sr
        {
            redditDetailsSearchView.text = sr
            presenter.startAPI(sr: sr)
        }
    }
    
    /// dismisses the current vc when back is clicked
    @objc func backClicked()
    {
        self.dismiss(animated: true, completion: nil)
    }

    /// retrievedAboutSubredditUpdateView after retrieving the Subreddit info update the view
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedAboutSubredditUpdateView(subreddit : Subreddit) {
        self.subDetails = subreddit
    }
    
    /// retrievedPostsUpdateView after retrieving the listing for posts under the subreddit update the view
    func retrievedPostsUpdateView(listing: FeedListing) {
        self.posts = listing.data?.children
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    /// retrievedAboutSubredditUpdateView after retrieving the Subreddit rules update the view
    ///
    /// - Parameter rules: as Rules the subreddit rules and moderation
    func retrievedAboutSubRulesUpdateView(rules: Rules) {
        self.rules = rules
    }
    
    /// navigate to RedditDetailsViewController using sr subreddit as parameter
    ///
    /// - Parameter sr: as String the subreddit
    func moveToDetails(sr : String)
    {
        let vc = UINavigation.vc(identifier: UINavigation.RedditDetails) as! RedditDetailsViewController
        vc.sr = sr
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    /// navigate to RedditDetailCommentsViewController using sr subreddit , id and feedChildListing as parameter
    ///
    /// - Parameter sr: as String the subreddit
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
    
    
    /// openComments opens the comments (RedditDetailCommentsViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openComments(index: Int, tag : Int) {
        if let child = posts?[index], let subreddit = posts?[index].data?.subreddit_name_prefixed, let id = posts?[index].data?.id{
            moveToComments(sr: subreddit, feedChildListing: child , id: id)
        }
    }
    
    /// openPreview opens the preview (RedditPreviewViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openPreview(index: Int, tag : Int) {
        let vc = UINavigation.vc(identifier: UINavigation.RedditPreview) as! RedditPreviewViewController
        if let list = posts
        {
            vc.image = cellChooser.getLink(list:  list , index: index)
            vc.previewDate = list[index].data?.created_utc?.toDate().fromNow()
            vc.previewLabel = list[index].data?.subreddit_name_prefixed
            vc.user = list[index].data?.author
            vc.previewTitle = list[index].data?.title
            
            if let comments = list[index].data?.num_comments, let upvotes =  list[index].data?.ups
            {
                vc.comments = "\(comments)"
                vc.upvote = "\(upvotes)"
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    /// openAbout opens the about info (RedditAboutViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openAbout(index: Int, tag : Int) {
        let vc = UINavigation.vc(identifier: UINavigation.RedditAbout) as! RedditAboutViewController
        vc.author = posts?[index].data?.author
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    /// openSubreddit opens the subreddit details (RedditDetailsViewController) modally using the cell's index
    ///
    /// - Parameters:
    ///   - index: as Int
    ///   - tag: as Int UNUSED
    func openSubreddit(index: Int, tag : Int) {
        print("Not allowed to")
    }
}
