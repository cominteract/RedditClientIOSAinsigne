//
//  RedditInboxViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditInboxViewController as RedditInboxView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditInboxViewController : BaseViewController, RedditInboxView, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    /// presenter as RedditInboxPresenter injected automatically to call implementations
    var presenter: RedditInboxPresenter!
    
    /// injector as RedditInboxInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditInboxInjectorImplementation()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var redditInboxTabBar: UITabBar!
    
    var isInbox = false
    
    @IBOutlet weak var redditLogsLoginView: RedditLogsLoginView!
    
    @IBOutlet weak var emptyLogsView: UIView!
    
    var inboxList : [FeedChildrenListing]?
    
    var overviewList : [FeedChildrenListing]?
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let newIsInbox = tabBar.items?.index(of : item) ?? 0 > 0
        if isInbox != newIsInbox
        {
            self.tableView.animateLtoR(parentView: self.view)
            isInbox = newIsInbox
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let overviewCount = overviewList?.count, !isInbox
        {
            return overviewCount
        }
        else if let inboxCount = inboxList?.count, isInbox
        {
            return inboxCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isInbox
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedditInboxMessagesTableViewCell") as! RedditInboxMessagesTableViewCell
            cell.redditInboxMessageLabel.text = inboxList?[indexPath.row].data?.author
            if let messagecount = inboxList?[indexPath.row].data?.body?.count, messagecount > 60, let message = inboxList?[indexPath.row].data?.body
            {
                let body: String = messagecount > 60 ? String(message.prefix(60)) : message
                cell.redditInboxMessageLabel.text = "\(body)"
            }
            if let daysFromNow = inboxList?[indexPath.row].data?.created_utc?.toDate().fromNow(){
                cell.redditInboxDateLabel.text = daysFromNow
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedditInboxActivityTableViewCell") as! RedditInboxActivityTableViewCell
            if let messagecount = overviewList?[indexPath.row].data?.body?.count, let message = overviewList?[indexPath.row].data?.body
            {
                let body: String = messagecount > 60 ? String(message.prefix(60)) : message
                cell.redditInboxActivityDescLabel.text = "\(body)"
            }
            cell.redditInboxActivityLabel.text = overviewList?[indexPath.row].data?.subreddit_name_prefixed
            if let daysFromNow = overviewList?[indexPath.row].data?.created_utc?.toDate().fromNow(){
                cell.redditInboxActivityDateLabel.text = "\(daysFromNow)"
            }
            return cell
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if presenter.isLogged()
        {
            emptyLogsView.isHidden = true
            redditLogsLoginView.isHidden = true
            if Config.getRefreshedInbox() == "Not"
            {
                presenter.startAPI()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        self.tableView.register(UINib.init(nibName: "RedditInboxActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditInboxActivityTableViewCell")
        self.tableView.register(UINib.init(nibName: "RedditInboxMessagesTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditInboxMessagesTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.redditInboxTabBar.delegate = self
        presenter.startAPI()
    }

    
    /// retrievedOverviewUpdateView when overview info of user is retrieved update the view
    ///
    /// - Parameter listing: as [FeedChildrenListing] overview info of user
    func retrievedOverviewUpdateView(listing: [FeedChildrenListing]) {
        overviewList = listing
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    /// retrievedInboxUpdateView when inbox of user is retrieved update the view
    ///
    /// - Parameter listing: as [FeedChildrenListing] inbox of user
    func retrievedInboxUpdateView(listing: [FeedChildrenListing]) {
        inboxList = listing
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    /// retrievedOverviewErrorUpdateView when retrieving the inbox and overview fails update the view
    ///
    /// - Parameter error: as String the error message when it fails
    func retrievedOverviewErrorUpdateView(error: String) {
        
    }
}
