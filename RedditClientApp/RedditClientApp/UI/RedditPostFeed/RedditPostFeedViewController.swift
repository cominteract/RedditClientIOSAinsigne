//
//  RedditPostFeedViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit


/// RedditPostFeedViewController as RedditPostFeedView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditPostFeedViewController : BaseViewController, RedditPostFeedView,PostAction {
    
    /// presenter as RedditPostFeedPresenter injected automatically to call implementations
    var presenter: RedditPostFeedPresenter!
    
    /// injector as RedditPostFeedInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditPostFeedInjectorImplementation()
    
    @IBOutlet weak var redditPostView: RedditPostView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        redditPostView.delegate = self
    }
    
    /// dismissView dismisses the current modally presented vc
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// linkPosted when post Link is selected navigate to PostActionViewController ready to submit link
    func linkPosted() {
       moveToAction(postType:PostType.Link)
        
    }
    
    /// imagePosted when post Image is selected navigate to PostActionViewController ready to submit image
    func imagePosted() {
        moveToAction(postType:PostType.Image)
    }
    
    /// videoPosted when post Link is selected navigate to PostActionViewController ready to submit video
    func videoPosted() {
        moveToAction(postType:PostType.Video)
    }
    
    /// textPosted when post text is selected navigate to PostActionViewController ready to submit text
    func textPosted() {
        moveToAction(postType:PostType.Text)
    }
    
    /// moveToAction navigates to the RedditPostActionViewController with postType parameter ready to submit
    ///
    /// - Parameter postType: as PostType the type of post to submit
    func moveToAction(postType : PostType)
    {
        let vc = UINavigation.vc(identifier: UINavigation.RedditPostAction) as! RedditPostActionViewController
        vc.postType = postType
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}
