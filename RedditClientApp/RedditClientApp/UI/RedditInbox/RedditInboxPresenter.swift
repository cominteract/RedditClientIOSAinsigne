//
//  RedditInboxPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditInboxView protocol for updating the view in the view controllers
protocol RedditInboxView: class {
    
    /// retrievedOverviewUpdateView when overview info of user is retrieved update the view
    ///
    /// - Parameter listing: as [FeedChildrenListing] overview info of user
    func retrievedOverviewUpdateView(listing : [FeedChildrenListing])
    /// retrievedInboxUpdateView when inbox of user is retrieved update the view
    ///
    /// - Parameter listing: as [FeedChildrenListing] inbox of user
    func retrievedInboxUpdateView(listing : [FeedChildrenListing])
    
    
    /// retrievedOverviewErrorUpdateView when retrieving the inbox and overview fails update the view
    ///
    /// - Parameter error: as String the error message when it fails
    func retrievedOverviewErrorUpdateView(error : String)
}

/// RedditInboxDelegate protocol for delegating implementations from the RedditInboxServices
protocol RedditInboxDelegate: class{
    /// retrievedOverview when overview info of user is retrieved
    ///
    /// - Parameter listing: as [FeedChildrenListing] overview info of user
    func retrievedOverview(listing : [FeedChildrenListing])
    /// retrievedInbox when inbox of user is retrieved
    ///
    /// - Parameter listing: as [FeedChildrenListing] inbox of user
    func retrievedInbox(listing : [FeedChildrenListing])
    /// retrievedOverviewError when retrieving the inbox and overview fails
    ///
    /// - Parameter error: as Error the error when it fails
    func retrievedOverviewError(error : Error)
}

/// RedditInboxPresenter protocol for implementing the RedditInboxPresenter
protocol RedditInboxPresenter {
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool
    /// starts the api through the presenter
    func startAPI()
}

/// RedditInboxPresenter implementation based on the presenter protocol
class RedditInboxPresenterImplementation : RedditInboxPresenter, RedditInboxDelegate {
    
    /// retrievedInbox when inbox of user is retrieved
    ///
    /// - Parameter listing: as [FeedChildrenListing] inbox of user
    func retrievedInbox(listing: [FeedChildrenListing]) {
        view?.retrievedInboxUpdateView(listing: listing)
    }
    
    /// retrievedOverview when overview info of user is retrieved
    ///
    /// - Parameter listing: as [FeedChildrenListing] overview info of user
    func retrievedOverview(listing: [FeedChildrenListing]) {
        view?.retrievedOverviewUpdateView(listing: listing)
    }
    
    /// retrievedOverviewError when retrieving the inbox and overview fails
    ///
    /// - Parameter error: as Error the error when it fails
    func retrievedOverviewError(error: Error) {
        view?.retrievedOverviewErrorUpdateView(error: error.localizedDescription)
    }
    
    /// starts the api through the presenter
    func startAPI() {
        service.startListing()
    }
    
    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    func isLogged() -> Bool
    {
        return service.isLogged()
    }

    /// RedditInboxView reference of the RedditInboxViewController as RedditInboxView type. Must be weak
    fileprivate weak var view: RedditInboxView?
    
    /// RedditInboxServices property to set the services used by the presenter
    var service : RedditInboxServices!
    
    /// initializes with the RedditInboxViewController as the RedditInboxView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditInboxViewController as the RedditInboxView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditInboxView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditInboxServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
