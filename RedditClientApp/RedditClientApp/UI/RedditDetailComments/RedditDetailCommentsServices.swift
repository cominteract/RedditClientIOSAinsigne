//
//  RedditDetailCommentsServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditDetailCommentsServices class for implementing the services needed for the presenter
class RedditDetailCommentsServices: NSObject {

    /// delegate for the implementation of the template generated RedditDetailCommentsServices
    weak var delegate : RedditDetailCommentsDelegate?
    
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
    
   
    
    
     /// startListing starts the api process to retrieve the comments and info about the subreddit using the ListingRetrieved, CommentsRetrieved and SubredditRetrieved closure callback
    ///
    /// - Parameters:
    ///   - sr: as String the subreddit as parameter
    ///   - id: as String the id as parameter
    func startDetailComments(sr : String,id : String)
    {
        let retrieved = ListingRetrieved()
        retrieved.didRetrievedListing = {
            (list : FeedListing, endPoint : APIEndpoint) in
            print("Listing Comments \(list.data?.children?.count) \(endPoint)")
            self.delegate?.retrievedPosts(listing: list ,endPoint: endPoint)
        }
        retrieved.didRetrievedError = error()
        let comretrieved = CommentsRetrieved()
        comretrieved.didRetrievedComments = {
            (comments : [Comments], endPoint : APIEndpoint) in
            print("Listing Comments \(comments.count) \(endPoint)")
            self.delegate?.retrievedComments(comments: comments ,endPoint: endPoint)
        }
        comretrieved.didRetrievedError = error()
        let subretrieved = SubredditRetrieved()
        subretrieved.didRetrievedSubreddit = {
            (subreddit : Subreddit , endPoint : APIEndpoint) in
            self.delegate?.retrievedAboutSubreddit(subreddit : subreddit, endPoint: endPoint)
        }
        subretrieved.didRetrievedError = error()
        apiManager.startAPI(endPoint: APIEndpoint.SubredditInfo, input: sr , isJson: false, retrieved: retrieved)
        apiManager.startAPI(endPoint: APIEndpoint.AbtSub, input: sr, isJson: false, retrieved: subretrieved)
        let subreddit = "\(sr),\(id)"
        apiManager.startAPI(endPoint: APIEndpoint.ArticleComments, input: subreddit, isJson: false, retrieved: comretrieved)
    }
}
