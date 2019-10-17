//
//  RedditCommunityServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditCommunityServices class for implementing the services needed for the presenter
class RedditCommunityServices: NSObject {

    /// delegate for the implementation of the template generated RedditCommunityServices
    weak var delegate : RedditCommunityDelegate?
    
    /// apiManager used in consuming the api related to data whether mock or from aws to be initialized
    var apiManager : APIManager
    
    /// authManager used in consuming the authentication api whether mock or from aws to be initialized
    var authManager : AuthManager
    /// initializes with the apiManager used in consuming the api related to data whether mock or from aws and authManager used in consuming the authentication api whether mock or from aws
    ///
    /// - Parameters:
    ///   - apiManager: apiManager:  apiManager used in consuming the api related to data whether mock or from aws
    ///   - authManager: authManager:  authManager used in consuming the authentication api whether mock or from aws
    init(apiManager : APIManager, authManager : AuthManager) {
        self.apiManager = apiManager
        self.authManager = authManager
    }
    
    
    /// startListing starts the api process to retrieve the subreddits subscribed using the ListingRetrieved closure callback
    func startListing() {
        let retrieved = ListingRetrieved()
        retrieved.didRetrievedListing = {
            (list : FeedListing, endPoint : APIEndpoint) in
            self.delegate?.retrievedSubscribed(listing: list)
        }
        retrieved.didRetrievedError = {
            (error : Error, revoked : Bool) in
            print("Listing \(error.localizedDescription)")
            
        }
        apiManager.startAPI(endPoint: APIEndpoint.MineSubreddit, input: nil, isJson: false, retrieved: retrieved)
    }
}
