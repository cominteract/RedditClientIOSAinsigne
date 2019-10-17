//
//  RedditPostActionPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 14/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import Foundation

/// RedditPostActionView protocol for updating the view in the view controllers
protocol RedditPostActionView: class {
    
    /// postedSuccessfullyUpdateView after submitting the post request and is successful update the view
    ///
    /// - Parameter message: as String the message when post is successful
    func postedSuccessfullyUpdateView(message : String)
    /// errorPostedUpdateView after submitting the post request and failed update the view
    ///
    /// - Parameter message: as String the message when submitting failed
    func errorPostedUpdateView(message : String)
}

/// RedditPostActionDelegate protocol for delegating implementations from the RedditPostActionServices
protocol RedditPostActionDelegate: class{
    /// postedSuccessfully after submitting the post request and is successful
    ///
    /// - Parameter message: as String the message when post is successful
    func postedSuccessfully(message : String)
    
    /// errorPosted after submitting the post request and failed
    ///
    /// - Parameter message: as String the message when submitting failed
    func errorPosted(message : String)
}

/// RedditPostActionPresenter protocol for implementing the RedditPostActionPresenter
protocol RedditPostActionPresenter {
    
    /// postText submits the text or link api request using the service connected to api manager
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to submit
    ///   - text: as String the content of the post to submit
    ///   - srname: as  String the subreddit to post the message or link to
    ///   - type: as PostType to identify whether it is a link or text
    func postText(title : String, text : String, srname : String, type : PostType)
    
    /// postMedia submits the image or video api request using the service connected to api manager
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to submit
    ///   - media: as Data the content of the post to submit
    ///   - srname: as  String the subreddit to post the image or video to
    ///   - type: as PostType to identify whether it is a image or video
    func postMedia(title : String, data : Data, srname : String, type : PostType)
}

/// RedditPostActionPresenter implementation based on the presenter protocol
class RedditPostActionPresenterImplementation : RedditPostActionPresenter, RedditPostActionDelegate {
    
    /// errorPosted after submitting the post request and failed
    ///
    /// - Parameter message: as String the message when submitting failed
    func errorPosted(message: String) {
        view?.errorPostedUpdateView(message: message)
    }
    
    /// postText submits the text or link api request using the service connected to api manager
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to submit
    ///   - text: as String the content of the post to submit
    ///   - srname: as  String the subreddit to post the message or link to
    ///   - type: as PostType to identify whether it is a link or text
    func postText(title: String, text: String, srname: String, type: PostType) {
        if type == PostType.Text{
            service.sendText(title: title, text: text, sr: srname, postType: type)
        }else{
            service.sendLink(title: title, url: text, sr: srname, postType: type)
        }
    }
    
    /// postMedia submits the image or video api request using the service connected to api manager
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to submit
    ///   - media: as Data the content of the post to submit
    ///   - srname: as  String the subreddit to post the image or video to
    ///   - type: as PostType to identify whether it is a image or video
    func postMedia(title: String, data: Data, srname: String, type: PostType) {
        if type == PostType.Image{
            service.sendImage(title: title, data: data, sr: srname, postType: type)
        }else{
            service.sendVideo(title: title, data: data, sr: srname, postType: type)
        }
    }
    
    /// postedSuccessfully after submitting the post request and is successful
    ///
    /// - Parameter message: as String the message when post is successful
    func postedSuccessfully(message: String) {
        view?.postedSuccessfullyUpdateView(message: message)
    }

    /// RedditPostActionView reference of the RedditPostActionViewController as RedditPostActionView type. Must be weak
    fileprivate weak var view: RedditPostActionView?
    
    /// RedditPostActionServices property to set the services used by the presenter
    var service : RedditPostActionServices!
    
    /// initializes with the RedditPostActionViewController as the RedditPostActionView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditPostActionViewController as the RedditPostActionView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditPostActionView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditPostActionServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
