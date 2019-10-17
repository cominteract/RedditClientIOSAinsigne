//
//  RedditAboutServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditAboutServices class for implementing the services needed for the presenter
class RedditAboutServices: NSObject {

    /// delegate for the implementation of the template generated RedditAboutServices
    weak var delegate : RedditAboutDelegate?
    
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
    
    /// startInfo starts the api to get the info about the user using the MeRetrieved closure callback
    ///
    /// - Parameter user: as String the user to get the info about
    func startInfo(user : String)
    {
        let meretrieved = MeRetrieved()
        meretrieved.didRetrievedMe = {
            (me : Me) in
            self.delegate?.retrievedMe(me : me)
        }
        meretrieved.didRetrievedError = error()
         apiManager.startAPI(endPoint: APIEndpoint.About, input: user, isJson: false, retrieved: meretrieved)
    }
    
}
