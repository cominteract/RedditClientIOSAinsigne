//
//  RedditDetailsPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditDetailsView protocol for updating the view in the view controllers
protocol RedditDetailsView: class {
    /// retrievedPostsUpdateView after retrieving the listing for posts under the subreddit update the view
    ///
    /// - Parameter listing: as [Comments] for the comment posts
    func retrievedPostsUpdateView(listing : FeedListing)
    
    /// retrievedAboutSubredditUpdateView after retrieving the Subreddit info update the view
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedAboutSubredditUpdateView(subreddit : Subreddit)
    
    
    /// retrievedAboutSubredditUpdateView after retrieving the Subreddit rules update the view
    ///
    /// - Parameter rules: as Rules the subreddit rules and moderation
    func retrievedAboutSubRulesUpdateView(rules : Rules)
}

/// RedditDetailsDelegate protocol for delegating implementations from the RedditDetailsServices
protocol RedditDetailsDelegate: class{
    /// retrievedPosts after retrieving the listing for posts under the subreddit
    ///
    /// - Parameter listing: as [Comments] for the comment posts
    func retrievedPosts(listing : FeedListing, endPoint : APIEndpoint)
    /// retrievedAboutSubreddit after retrieving the Subreddit info
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedAboutSubreddit(subreddit : Subreddit, endPoint : APIEndpoint)
    
    
    /// retrievedAboutSubreddit after retrieving the Subreddit rules
    ///
    /// - Parameter rules: as Rules the subreddit rules and moderation
    func retrievedAboutSubRules(rules : Rules)
}

/// RedditDetailsPresenter protocol for implementing the RedditDetailsPresenter
protocol RedditDetailsPresenter {
    
    /// starts the api through the presenter
    ///
    /// - Parameters:
    ///   - sr: as String the subreddit text to be used as parameter
    func startAPI(sr : String)
}

/// RedditDetailsPresenter implementation based on the presenter protocol
class RedditDetailsPresenterImplementation : RedditDetailsPresenter, RedditDetailsDelegate {

    /// RedditDetailsView reference of the RedditDetailsViewController as RedditDetailsView type. Must be weak
    fileprivate weak var view: RedditDetailsView?
    
    /// RedditDetailsServices property to set the services used by the presenter
    var service : RedditDetailsServices!
    
    /// initializes with the RedditDetailsViewController as the RedditDetailsView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditDetailsViewController as the RedditDetailsView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditDetailsView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditDetailsServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
    
    /// starts the api through the presenter
    ///
    /// - Parameters:
    ///   - sr: as String the subreddit text to be used as parameter
    func startAPI(sr : String)
    {
        service.startPosts(sr: sr)
    }
    
    /// retrievedAboutSubreddit after retrieving the Subreddit info
    ///
    /// - Parameter subreddit: as Subreddit the subreddit info
    func retrievedAboutSubreddit(subreddit: Subreddit, endPoint: APIEndpoint) {
        view?.retrievedAboutSubredditUpdateView(subreddit: subreddit)
    }
    
    /// retrievedPosts after retrieving the listing for posts under the subreddit
    ///
    /// - Parameter listing: as [Comments] for the comment posts
    func retrievedPosts(listing: FeedListing, endPoint: APIEndpoint) {
        view?.retrievedPostsUpdateView(listing: listing)
    }
    
    /// retrievedAboutSubreddit after retrieving the Subreddit rules
    ///
    /// - Parameter rules: as Rules the subreddit rules and moderation
    func retrievedAboutSubRules(rules: Rules) {
        view?.retrievedAboutSubRulesUpdateView(rules: rules)
    }
}
