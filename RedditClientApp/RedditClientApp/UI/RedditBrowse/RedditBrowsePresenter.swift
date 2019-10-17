//
//  RedditBrowsePresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditBrowseView protocol for updating the view in the view controllers
protocol RedditBrowseView: class {
    
    /// retrievedAllUpdateView updates the view after retrieving the listing for All
    ///
    /// - Parameter listing: as FeedListing for All
    func retrievedAllUpdateView(listing: FeedListing)
    /// retrievedPopularUpdateView updates the view after retrieving the listing for Popular
    ///
    /// - Parameter listing: as FeedListing for Popular
    func retrievedPopularUpdateView(listing: FeedListing?)
}

/// RedditBrowseDelegate protocol for delegating implementations from the RedditBrowseServices
protocol RedditBrowseDelegate: class{
    /// retrievedAllUpdateView after retrieving the listing for All
    ///
    /// - Parameter listing: as FeedListing for All
    func retrievedAll(listing: FeedListing)
    /// retrievedPopularUpdateView after retrieving the listing for Popular
    ///
    /// - Parameter listing: as FeedListing for Popular
    func retrievedPopular(listing: FeedListing?)
    
}

/// RedditBrowsePresenter protocol for implementing the RedditBrowsePresenter
protocol RedditBrowsePresenter {
    /// starts the api through the presenter
    func startAPI()
}

/// RedditBrowsePresenter implementation based on the presenter protocol
class RedditBrowsePresenterImplementation : RedditBrowsePresenter, RedditBrowseDelegate {
    /// retrievedAllUpdateView after retrieving the listing for All
    ///
    /// - Parameter listing: as FeedListing for All
    func retrievedAll(listing: FeedListing) {
        view?.retrievedAllUpdateView(listing: listing)
    }
    /// retrievedPopularUpdateView updates the view after retrieving the listing for Popular
    ///
    /// - Parameter listing: as FeedListing for Popular
    func retrievedPopular(listing: FeedListing?) {
        view?.retrievedPopularUpdateView(listing: listing)
    }
    
    /// starts the api through the presenter
    func startAPI() {
        service.startListing()
    }

    /// RedditBrowseView reference of the RedditBrowseViewController as RedditBrowseView type. Must be weak
    fileprivate weak var view: RedditBrowseView?
    
    /// RedditBrowseServices property to set the services used by the presenter
    var service : RedditBrowseServices!
    
    /// initializes with the RedditBrowseViewController as the RedditBrowseView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditBrowseViewController as the RedditBrowseView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditBrowseView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditBrowseServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
