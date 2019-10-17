//
//  RedditFeedPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditFeedView protocol for updating the view in the view controllers
protocol RedditFeedView: class {
    
    /// retrievedNewsUpdateView after retrieving the listings related to news uupdate the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedNewsUpdateView(listing : FeedListing)
    /// retrievedPopularUpdateView after retrieving the listings related to popular update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedPopularUpdateView(listing : FeedListing)
    /// retrievedHomeUpdateView after retrieving the listings related to user preferences update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedHomeUpdateView(listing : FeedListing)
    /// retrievedTrendingUpdateView after retrieving the listings related to trending update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedTrendingUpdateView(listing : FeedListing)
    /// retrievedSubscribedUpdateView after retrieving the listings subreddit subscribed update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedSubscribedUpdateView(listing : FeedListing)
    /// retrievedSearchedUpdateView after retrieving the listings subreddit searched update the view
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrieveSearchedUpdateView(searched : SearchSubreddit)
}

/// RedditFeedDelegate protocol for delegating implementations from the RedditFeedServices
protocol RedditFeedDelegate: class{
    /// retrievedNews after retrieving the listings
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedNews(listing : FeedListing)
    // retrievedPopular after retrieving the listings related to popular
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedPopular(listing : FeedListing)
    /// retrievedHome after retrieving the listings related to user preferences
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedHome(listing : FeedListing)
    /// retrievedTrending after retrieving the listings related to trending
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedTrending(listing : FeedListing)
    /// retrievedSubscribed after retrieving the listings subreddit subscribed
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedSubscribed(listing : FeedListing)
    /// retrievedSearched after retrieving the listings subreddit searched
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrieveSearched(searched : SearchSubreddit)
}

/// RedditFeedPresenter protocol for implementing the RedditFeedPresenter
protocol RedditFeedPresenter {
    /// starts the api through the presenter
    func startAPI()
    
    /// starts the api to search subreddits
    ///
    /// - Parameter input: as String the query to be searched
    func startSearch(input : String)
    
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool
    
    /// refresh the api when logged out
    func refresh()
}

/// RedditFeedPresenter implementation based on the presenter protocol
class RedditFeedPresenterImplementation : RedditFeedPresenter, RedditFeedDelegate {

    /// refresh the api when logged out
    func refresh() {
        service.refreshLoggedOut()
    }
    /// retrievedSearched after retrieving the listings subreddit searched
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrieveSearched(searched: SearchSubreddit) {
        view?.retrieveSearchedUpdateView(searched: searched)
    }

    /// retrievedSubscribed after retrieving the listings subreddit subscribed
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedSubscribed(listing: FeedListing) {
        view?.retrievedSubscribedUpdateView(listing: listing)
    }
    
    /// starts the api to search subreddits
    ///
    /// - Parameter input: as String the query to be searched
    func startSearch(input: String) {
        service.startSearch(input: input)
    }
    
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool {
        return service.isLogged()
    }
    /// starts the api through the presenter
    func startAPI() {
        service.startListing()
    }
    
    /// retrievedTrending after retrieving the listings related to trending
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedTrending(listing: FeedListing) {
        view?.retrievedTrendingUpdateView(listing: listing)
    }
    
    /// retrievedHome after retrieving the listings related to user preferences
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedHome(listing: FeedListing) {
        view?.retrievedHomeUpdateView(listing: listing)
    }
    
    /// retrievedNews after retrieving the listings
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedNews(listing: FeedListing) {
        view?.retrievedNewsUpdateView(listing: listing)
    }
    // retrievedPopular after retrieving the listings related to popular
    ///
    /// - Parameter listing: as FeedListing the listing retrieved
    func retrievedPopular(listing: FeedListing) {
        view?.retrievedPopularUpdateView(listing: listing)
    }
    
    /// RedditFeedView reference of the RedditFeedViewController as RedditFeedView type. Must be weak
    fileprivate weak var view: RedditFeedView?
    
    /// RedditFeedServices property to set the services used by the presenter
    var service : RedditFeedServices!
    
    /// initializes with the RedditFeedViewController as the RedditFeedView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditFeedViewController as the RedditFeedView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditFeedView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditFeedServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
