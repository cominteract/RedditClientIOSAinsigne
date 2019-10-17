//
//  RedditCommunityViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditCommunityViewController as RedditCommunityView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditCommunityViewController : BaseViewController, RedditCommunityView, UITableViewDelegate, UITableViewDataSource {
    
    /// presenter as RedditCommunityPresenter injected automatically to call implementations
    var presenter: RedditCommunityPresenter!
    
    /// injector as RedditCommunityInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditCommunityInjectorImplementation()
    
    var interests : [String]?
    
    @IBOutlet weak var tableView: UITableView!
    
    var subscribedList : FeedListing?
    
    var chooser = false
    
    weak var delegate : SRChooseAction?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditFilterTableViewCell") as! RedditFilterTableViewCell
        
        if indexPath.row > 2 && !chooser
        {
            cell.redditFilterLabel.text = subscribedList?.data?.children?[indexPath.row - 3].data?.display_name_prefixed
            cell.redditFilterDescriptionLabel.text = subscribedList?.data?.children?[indexPath.row - 3].data?.public_description
        }
        else if indexPath.row < 3 && !chooser
        {
            cell.redditFilterLabel.text = Constants.filterTitles[indexPath.row]
            cell.redditFilterDescriptionLabel.text = Constants.filterDescs[indexPath.row]
        }
        else
        {
            cell.redditFilterLabel.text = subscribedList?.data?.children?[indexPath.row ].data?.display_name_prefixed
            cell.redditFilterDescriptionLabel.text = subscribedList?.data?.children?[indexPath.row ].data?.public_description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let srname = subscribedList?.data?.children?[indexPath.row].data?.display_name, chooser
        {
            delegate?.chosenSR(srname: srname )
            self.dismiss(animated: true, completion: nil)
        }
        else if !chooser, indexPath.row > 2,   let sr = subscribedList?.data?.children?[indexPath.row - 3].data?.display_name
        {
            let vc = UINavigation.vc(identifier: UINavigation.RedditDetails) as! RedditDetailsViewController
            vc.sr = "/r/\(sr)"
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
        else if !chooser, indexPath.row == 1
        {
            let vc = UINavigation.vc(identifier: UINavigation.RedditBrowse) as! RedditBrowseViewController
            vc.isPopular = true
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
        else if !chooser, indexPath.row == 2
        {
            let vc = UINavigation.vc(identifier: UINavigation.RedditBrowse) as! RedditBrowseViewController
            vc.isPopular = false
            DispatchQueue.main.async { [weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = subscribedList?.data?.children?.count
        {
            let co = chooser == false ? 3 : 0
            return count + co
        }
        return 3
    }
    
    /// retrievedSubscribedUpdateView after retrieving the subreddits subscribed update the view
    ///
    /// - Parameter listing: as FeedListing the listing of subreddits subscribed to
    func retrievedSubscribedUpdateView(listing: FeedListing) {
        subscribedList = listing
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        self.tableView.register(UINib.init(nibName: "RedditFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "RedditFilterTableViewCell")
        interests = Config.getInterest()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        presenter.startSubscribedListing()
    }
}
