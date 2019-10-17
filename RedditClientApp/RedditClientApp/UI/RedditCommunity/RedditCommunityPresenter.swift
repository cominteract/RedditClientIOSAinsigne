//
//  RedditCommunityPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditCommunityView protocol for updating the view in the view controllers
protocol RedditCommunityView: class {
    
    /// retrievedSubscribedUpdateView after retrieving the subreddits subscribed update the view
    ///
    /// - Parameter listing: as FeedListing the listing of subreddits subscribed to
    func retrievedSubscribedUpdateView(listing : FeedListing)
}

/// RedditCommunityDelegate protocol for delegating implementations from the RedditCommunityServices
protocol RedditCommunityDelegate: class{
    /// retrievedSubscribed after retrieving the subreddits subscribed
    ///
    /// - Parameter listing: as FeedListing the listing of subreddits subscribed to
    func retrievedSubscribed(listing : FeedListing)
}

/// RedditCommunityPresenter protocol for implementing the RedditCommunityPresenter
protocol RedditCommunityPresenter {
    
    /// start the listing for subscribed subreddits
    func startSubscribedListing()
}

/// RedditCommunityPresenter implementation based on the presenter protocol
class RedditCommunityPresenterImplementation : RedditCommunityPresenter, RedditCommunityDelegate {
    
    /// start the listing for subscribed subreddits
    func startSubscribedListing() {
        service.startListing()
    }
    
    /// retrievedSubscribedUpdateView after retrieving the subreddits subscribed update the view
    ///
    /// - Parameter listing: as FeedListing the listing of subreddits subscribed to
    func retrievedSubscribed(listing: FeedListing) {
        view?.retrievedSubscribedUpdateView(listing: listing)
    }
    
    /// RedditCommunityView reference of the RedditCommunityViewController as RedditCommunityView type. Must be weak
    fileprivate weak var view: RedditCommunityView?
    
    /// RedditCommunityServices property to set the services used by the presenter
    var service : RedditCommunityServices!
    
    /// initializes with the RedditCommunityViewController as the RedditCommunityView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditCommunityViewController as the RedditCommunityView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditCommunityView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditCommunityServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
