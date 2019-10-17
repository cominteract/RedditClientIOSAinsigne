//
//  RedditPostFeedPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// RedditPostFeedView protocol for updating the view in the view controllers
protocol RedditPostFeedView: class {
  
}

/// RedditPostFeedDelegate protocol for delegating implementations from the RedditPostFeedServices
protocol RedditPostFeedDelegate: class{
    
}

/// RedditPostFeedPresenter protocol for implementing the RedditPostFeedPresenter
protocol RedditPostFeedPresenter {

}

/// RedditPostFeedPresenter implementation based on the presenter protocol
class RedditPostFeedPresenterImplementation : RedditPostFeedPresenter, RedditPostFeedDelegate {
    


    /// RedditPostFeedView reference of the RedditPostFeedViewController as RedditPostFeedView type. Must be weak
    fileprivate weak var view: RedditPostFeedView?
    
    /// RedditPostFeedServices property to set the services used by the presenter
    var service : RedditPostFeedServices!
    
    /// initializes with the RedditPostFeedViewController as the RedditPostFeedView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: RedditPostFeedViewController as the RedditPostFeedView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : RedditPostFeedView,
         apiManager : APIManager, authManager : AuthManager) {
        service = RedditPostFeedServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
}
