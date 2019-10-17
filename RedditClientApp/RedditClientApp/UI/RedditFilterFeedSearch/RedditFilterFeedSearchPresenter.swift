//
//  RedditFilterFeedSearchPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditFilterFeedSearchView protocol for updating the view in the view controllers
protocol RedditFilterFeedSearchView: class {
  
}

/// RedditFilterFeedSearchDelegate protocol for delegating implementations from the RedditFilterFeedSearchServices
protocol RedditFilterFeedSearchDelegate: class{
    
}

/// RedditFilterFeedSearchPresenter protocol for implementing the RedditFilterFeedSearchPresenter
protocol RedditFilterFeedSearchPresenter {

}
// TODO : Unused
/// RedditFilterFeedSearchPresenter implementation based on the presenter protocol
class RedditFilterFeedSearchPresenterImplementation : RedditFilterFeedSearchPresenter, RedditFilterFeedSearchDelegate {
    


    /// RedditFilterFeedSearchView reference of the RedditFilterFeedSearchViewController as RedditFilterFeedSearchView type. Must be weak
    fileprivate weak var view: RedditFilterFeedSearchView?
    
    /// RedditFilterFeedSearchServices property to set the services used by the presenter
    var service : RedditFilterFeedSearchServices!
    
    /// initializes with the RedditFilterFeedSearchViewController as the RedditFilterFeedSearchView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditFilterFeedSearchViewController as the RedditFilterFeedSearchView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditFilterFeedSearchView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditFilterFeedSearchServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
