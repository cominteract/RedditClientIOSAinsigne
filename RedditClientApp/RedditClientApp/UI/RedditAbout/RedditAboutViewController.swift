//
//  RedditAboutViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditAboutViewController as RedditAboutView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditAboutViewController : BaseViewController, RedditAboutView {
    
    /// presenter as RedditAboutPresenter injected automatically to call implementations
    var presenter: RedditAboutPresenter!
    
    /// injector as RedditAboutInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditAboutInjectorImplementation()
    
    @IBOutlet weak var redditAboutKarmaLabel: UILabel!
    
    @IBOutlet weak var redditAboutImageView: UIImageView!
    
    @IBOutlet weak var redditAboutLabel: UILabel!
    
    @IBOutlet weak var redditAboutDateLabel: UILabel!
    
    @IBOutlet weak var redditAboutUserLabel: UILabel!
    
    @IBOutlet weak var redditAboutCommentKarma: UILabel!
    
    @IBAction func viewProfileClicked(_ sender: Any) {
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func blockUserClicked(_ sender: Any) {
    }
    
    @IBAction func startChatClicked(_ sender: Any) {
    }
    
    var author : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        if let author = author
        {
            presenter.startAPI(user: author)
        }
    }
    
    /// retrievedMeUpdateView after retrieving the Me response update the view
    ///
    /// - Parameter me: as Me info about the current user
    func retrievedMeUpdateView(me: Me) {
        DispatchQueue.main.async { [weak self] in
            self?.redditAboutLabel.text = me.data?.subreddit?.title
            if let image = me.data?.icon_img
            {
                self?.redditAboutImageView.downloadedFrom(link: image)
            }
            if let commentkarma = me.data?.comment_karma
            {
                self?.redditAboutCommentKarma.text = "\(commentkarma)"
                if commentkarma > 1000
                {
                    let kkarma = (Double(commentkarma)/Double(1000)).roundTo(value: 2)
                    self?.redditAboutCommentKarma.text = "\(kkarma)k"
                }
            }
            if let date = me.data?.created_utc?.toDate().fromNow()
            {
                 self?.redditAboutDateLabel.text = "\(date)"
            }
            if let karma = me.data?.link_karma
            {
                self?.redditAboutKarmaLabel.text = "\(karma)"
                if karma > 1000
                {
                    let kkarma = (Double(karma)/Double(1000)).roundTo(value: 2)
                    self?.redditAboutKarmaLabel.text = "\(kkarma)k"
                }
            }
            if let name = me.data?.subreddit?.display_name_prefixed
            {
                self?.redditAboutUserLabel.text = name
            }
        }
    }
}
