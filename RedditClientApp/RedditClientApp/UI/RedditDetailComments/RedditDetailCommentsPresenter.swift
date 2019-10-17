//
//  RedditDetailCommentsPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditDetailCommentsView protocol for updating the view in the view controllers
protocol RedditDetailCommentsView: class {
    
    
    /// retrievedCommentPostsUpdateView after retrieving the listing for post comments update the view
    ///
    /// - Parameter listing: as [Comments] for the comment posts
    func retrievedCommentPostsUpdateView(listing : [Comments])
    
    /// retrievedCommentAboutSubreddit after retrieving the Subreddit info update the view
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedCommentAboutSubredditUpdateView(subreddit : Subreddit)
}

/// RedditDetailCommentsDelegate protocol for delegating implementations from the RedditDetailCommentsServices
protocol RedditDetailCommentsDelegate: class{
    //TODO unused
    func retrievedPosts(listing : FeedListing, endPoint : APIEndpoint)
    
    /// retrievedCommentAboutSubreddit after retrieving the Subreddit info
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedComments(comments : [Comments], endPoint : APIEndpoint)
    
    /// retrievedCommentAboutSubreddit after retrieving the Subreddit info
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedAboutSubreddit(subreddit : Subreddit, endPoint : APIEndpoint)
    
}

/// RedditDetailCommentsPresenter protocol for implementing the RedditDetailCommentsPresenter
protocol RedditDetailCommentsPresenter {
    
    /// starts the api through the presenter
    ///
    /// - Parameters:
    ///   - sr: as String the subreddit text to be used as parameter
    ///   - id: as String the id text to be used as parameter
    func startAPI(sr : String, id : String)
}

/// RedditDetailCommentsPresenter implementation based on the presenter protocol
class RedditDetailCommentsPresenterImplementation : RedditDetailCommentsPresenter, RedditDetailCommentsDelegate {
    func retrievedPosts(listing: FeedListing, endPoint: APIEndpoint) {
        
    }
    
    /// RedditDetailCommentsView reference of the RedditDetailCommentsViewController as RedditDetailCommentsView type. Must be weak
    fileprivate weak var view: RedditDetailCommentsView?
    
    /// RedditDetailCommentsServices property to set the services used by the presenter
    var service : RedditDetailCommentsServices!
    
    /// initializes with the RedditDetailCommentsViewController as the RedditDetailCommentsView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditDetailCommentsViewController as the RedditDetailCommentsView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditDetailCommentsView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditDetailCommentsServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
    
    /// starts the api through the presenter
    ///
    /// - Parameters:
    ///   - sr: as String the subreddit text to be used as parameter
    ///   - id: as String the id text to be used as parameter
    func startAPI(sr : String, id : String)
    {
        service.startDetailComments(sr: sr, id:id)
    }
    
    /// retrievedCommentAboutSubreddit after retrieving the Subreddit info update the view
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedComments(comments: [Comments], endPoint: APIEndpoint) {
        view?.retrievedCommentPostsUpdateView(listing: comments)
    }
    
    /// retrievedCommentAboutSubreddit after retrieving the Subreddit info
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedAboutSubreddit(subreddit: Subreddit, endPoint: APIEndpoint) {
        view?.retrievedCommentAboutSubredditUpdateView(subreddit: subreddit)
    }
}
