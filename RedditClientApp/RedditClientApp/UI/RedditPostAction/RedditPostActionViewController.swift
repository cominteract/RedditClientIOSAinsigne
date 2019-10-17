//
//  RedditPostActionViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 14/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

protocol SRChooseAction : class {
    func chosenSR(srname : String)
}

/// RedditPostActionViewController as RedditPostActionView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditPostActionViewController : BaseViewController, RedditPostActionView, RedditPostHeaderActions, RedditPostMediaAction, RedditPostTextAction, SRChooseAction {
 
    let valid = Validation()
    
    /// presenter as RedditPostActionPresenter injected automatically to call implementations
    var presenter: RedditPostActionPresenter!
    
    /// injector as RedditPostActionInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditPostActionInjectorImplementation()
    
    var postType : PostType = PostType.Text
    
    @IBOutlet weak var redditPostTextView: RedditPostTextView!
    
    @IBOutlet weak var redditPostHeaderView: RedditPostHeaderView!
    
    @IBOutlet weak var redditPostImageView: RedditPostImageView!
    
    var srname = "test"
    func chosenSR(srname: String) {
        self.srname = srname
        redditPostHeaderView.chooseCommunity.setTitle(self.srname, for: UIControl.State.normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if postType == PostType.Text || postType == PostType.Link
        {
            if postType == PostType.Link
            {
                redditPostTextView.redditPostTextField.placeholder = "http://"
            }
            redditPostTextView.isHidden = false
            redditPostImageView.isHidden = true
        }
        else
        {
            redditPostTextView.isHidden = true
            redditPostImageView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injector.inject(viewController: self)
        redditPostImageView.delegate = self
        redditPostTextView.delegate = self
        redditPostHeaderView.delegate = self
    }
    
    /// postClicked submits the POST request to send text and whatever according to PostType
    func postClicked() {
        if let title = redditPostTextView.redditPostTitleField.text, let text = redditPostTextView.redditPostTextField.text{
            sendingTitleAndText(title: title, text: text, postType: postType)
       }
        
    }
    
    /// communityClicked opens RedditCommunityViewController when selecting a particular subreddit followed to in order to submit the request
    func communityClicked() {
        let vc = UINavigation.vc(identifier: UINavigation.RedditCommunity) as! RedditCommunityViewController        
        vc.chooser = true
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    /// closeClicked dismisses the current vc
    func closeClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    ///  sendingTitleAndMedia delegates sending String and Data parameters identifying whether it is a image or a video through PostType
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to send
    ///   - media: as Data the data whether video or image
    ///   - postType: as PostType identifier
    func sendingTitleAndMedia(title: String, media: Data, postType : PostType) {
        sendAlert(title: "Image/Video upload unavailable", message: "Due to oauth")
    }
    
    
    ///  sendingTitleAndText delegates sending String parameters identifying whether it is a link or a normal text through PostType
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to send
    ///   - text: as String the text whether normal or link
    ///   - postType: as PostType identifier
    func sendingTitleAndText(title: String, text: String, postType : PostType) {
        if srname == ""
        {
            srname = "test"
        }
        
        
        let inputValidation = InputValidation()
        
        inputValidation.didInputValid = { [weak self]
            (notif : (String,String)) in
            if let srname = self?.srname
            {
                self?.presenter.postText(title: title, text: text, srname: srname, type: postType)
            }
        }
        inputValidation.didInputInvalidWithError = { [weak self]
            (notif : (String,String)) in
            self?.sendAlert(title: notif.0, message: notif.1)
        }
        if postType == PostType.Link
        {
            valid.isValidUrl(text: text, inputValidation: inputValidation)
        }
        else
        {
            presenter.postText(title: title, text: text, srname: srname, type: postType)
        }
    }
    
    
    
    /// postedSuccessfullyUpdateView after submitting the post request and is successful update the view
    ///
    /// - Parameter message: as String the message when post is successful
    func postedSuccessfullyUpdateView(message: String) {
        sendAlert(title: "Sent successfully", message: message)
    }
    
    /// errorPostedUpdateView after submitting the post request and failed update the view
    ///
    /// - Parameter message: as String the message when submitting failed
    func errorPostedUpdateView(message: String) {
        sendAlert(title: "Error in posting", message: message)
    }
}
