//
//  RedditBrowseServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditBrowseServices class for implementing the services needed for the presenter
class RedditBrowseServices: NSObject {

    /// delegate for the implementation of the template generated RedditBrowseServices
    weak var delegate : RedditBrowseDelegate?
    
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
    
    
    /// startListing starts the api process to retrieve the all and popular listings using the ListingRetrieved closure callback
    func startListing()
    {
        let retrieved = ListingRetrieved()
        retrieved.didRetrievedListing = { [weak self]
            (list : FeedListing, endPoint : APIEndpoint) in
            print("Listing \(list.data?.children?.count) \(endPoint)")
            if endPoint == APIEndpoint.SubAll{
                self?.delegate?.retrievedAll(listing: list)
            }
            else {
                self?.delegate?.retrievedPopular(listing: list)
            }
        }
        retrieved.didRetrievedError = error()
        apiManager.startAPI(endPoint: APIEndpoint.SubAll, input: nil, isJson: false, retrieved: retrieved)
        apiManager.startAPI(endPoint: APIEndpoint.SubPopular, input: nil, isJson: false, retrieved: retrieved)
    }
    
    func error() ->  ((Error, Bool) -> Void)?
    {
        return {
            (error : Error, revoked : Bool) in
            print("Listing \(error.localizedDescription)")
        }
    }
}
