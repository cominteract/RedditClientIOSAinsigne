//
//  RedditAuthManager.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditAuthManager: AuthManager {
   
    /// startAuth starts the authentication process using a callback from reddit
    ///
    /// - Parameter authRetrieve: the closure callback used in determining whether authentication is successful as TokenRetrieve
    override func startAuth(authRetrieve : TokenRetrieve)
    {
        Config.appDelegate.tokenRetrieve = authRetrieve
        let commaSeparatedScopeString = Config.scopes.joined(separator: ",")
        guard let authorizationURL = URL(string: "https://www.reddit.com/api/v1/authorize.compact?client_id=" + Config.client_id + "&response_type=code&state=" + Config.state + "&redirect_uri=" + Config.redirect_uri + "&duration=permanent&scope=" + commaSeparatedScopeString)
            else {
                return
        }
        if #available (iOS 10.0, *) {
            UIApplication.shared.open(authorizationURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(authorizationURL)
        }
    }
    
    /// refreshAuth refreshes the token using a callback from reddit
    ///
    /// - Parameter authRetrieve: the closure callback used in determining whether refreshing the authentication is successful as TokenRetrieve
    override func refreshAuth(authRetrieve : TokenRetrieve){
        if let refreshToken = Config.getRefreshToken(), let request = Config.requestForRefresh(refreshToken){
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                if responseString != nil{
                    do {
                        let decoder = JSONDecoder()
                        let authToken = try decoder.decode(TokenResponse.self, from: data)
                        authRetrieve.didRetrieveToken!(authToken)
                        
                    } catch let err {
                        authRetrieve.didEncounterError!(ErrorCases.authError(), false)
                    }
                }
                else{
                    authRetrieve.didEncounterError!(ErrorCases.authError(), false)
                }
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        }
    }

    /// isLogged checks whether the user is logged or not
    ///
    /// - Returns: as Bool to identify if user is logged
    override func isLogged() -> Bool
    {
        if let refreshDate = Config.getRefreshDate()?.toDate(){
            return Config.getOauthToken() != nil && refreshDate > Date()
        }
        return false
    }
    
}
