//
//  RedditDetailsServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditDetailsServices class for implementing the services needed for the presenter
class RedditDetailsServices: NSObject {

    /// delegate for the implementation of the template generated RedditDetailsServices
    weak var delegate : RedditDetailsDelegate?
    
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
    
    func error() ->  ((Error, Bool) -> Void)?
    {
        return {
            (error : Error, revoked : Bool) in
            print("Listing \(error.localizedDescription)")
            
        }
    }
    
    
    /// startLPosts starts the api process to retrieve the posts and info about the subreddit using the ListingRetrieved, RulesRetrieved and SubredditRetrieved closure callback
    ///
    /// - Parameter sr: as String the subreddit as parameter
    func startPosts(sr : String)
    {
        let retrieved = ListingRetrieved()
        retrieved.didRetrievedListing = {
            (list : FeedListing, endPoint : APIEndpoint) in
            print("Listing Posts \(endPoint)")
            self.delegate?.retrievedPosts(listing: list,endPoint: endPoint)
        }
        retrieved.didRetrievedError = error()
        
        let subretrieved = SubredditRetrieved()
        subretrieved.didRetrievedSubreddit = {
            (subreddit : Subreddit , endPoint : APIEndpoint) in
            self.delegate?.retrievedAboutSubreddit(subreddit : subreddit ,endPoint: endPoint)
        }
        
        subretrieved.didRetrievedError = error()
        apiManager.startAPI(endPoint: APIEndpoint.Input, input: sr , isJson: false, retrieved: retrieved)
        apiManager.startAPI(endPoint: APIEndpoint.AbtSub, input: sr, isJson: false, retrieved: subretrieved)
        
        
        let ruleretrieved = RulesRetrieved()
        ruleretrieved.didRetrievedRules = {
            (rule : Rules, endPoint : APIEndpoint) in
            print("Listing Rules \(endPoint)")
            //self.delegate?.retrievedPosts(listing: list)
            self.delegate?.retrievedAboutSubRules(rules: rule)
        }
        ruleretrieved.didRetrievedError = error()
        
        
        apiManager.startAPI(endPoint: APIEndpoint.AbtSubRules, input: sr, isJson: false, retrieved: ruleretrieved)
        
    }
    
    
}
