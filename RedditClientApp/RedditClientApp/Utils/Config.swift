//
//  Config.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

struct Config {
    public static let sharedInstance = Config()
    public static let baseAuthURL = "https://www.reddit.com"
    public static let baseAPIURL = "https://oauth.reddit.com"
    public static let redirect_uri = "rditai://response"
    public static let client_id = "Q6SUp3vgRqczhQ"
    public static let scopes = ["identity", "edit", "flair", "history", "modconfig", "modflair", "modlog", "modposts", "modwiki", "mysubreddits", "privatemessages", "read", "report", "save", "submit", "subscribe", "vote", "wikiedit", "wikiread"]
    public static let state = "aicodebase"
    public static let recentsearch_key = "recentsearch"
    public static let interest_key = "interest"
    public static let token_key = "oauthtoken"
    public static let username_key = "username"
    public static let reftoken_key = "refoauthtoken"
    public static let refdate_key = "refdate"
    public static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    /// Application verison, be updated by Info.plist later.
    let version: String = "0.0.0"
    /// Bundle identifier, be updated by Info.plist later.
    let bundleIdentifier: String = "com.andreinsigne.RedditClientApp"
    /// Developer's reddit user name
    let developerName: String = "KleinBarbarossa"
    /// OAuth redirect URL you register
    /**
     Returns User-Agent for API
     */
    var userAgent: String {
        return "ios:" + bundleIdentifier + ":v" + version + "(by /u/" + developerName + ")"
    }
    
    
    /// updates the recent search results
    ///
    /// - Parameters:
    ///   - value: new value to update as [String]
    ///   - key: the identifier from the Keys as String
    static func updateRecentSearch(value : [String])
    {
        let defaults = UserDefaults.standard
        var recents = ""
        for i in value
        {
            recents.append("\(i),")
        }
        recents.removeLast()
        defaults.set(recents, forKey: recentsearch_key)
    }
    
    /// returns the recent search results saved
    ///
    /// - Returns: recents as String after saving
    static func getRecentsSearch() -> [String]?
    {
        let defaults = UserDefaults.standard
        let recents = defaults.string(forKey: recentsearch_key)?.components(separatedBy: ",")
        return recents
    }
    
    
    
    /// updates the new interest
    ///
    /// - Parameters:
    ///   - value: new value to update as [String]
    ///   - key: the identifier from the Keys as String
    static func updateInterest(value : [String])
    {
        let defaults = UserDefaults.standard
        var interests = ""
        for i in value
        {
            interests.append("\(i),")
        }
        interests.removeLast()
        defaults.set(interests, forKey: interest_key)
    }
    
    /// returns the new interest saved
    ///
    /// - Returns: interests as [String] after saving
    static func getInterest() -> [String]?
    {
        let defaults = UserDefaults.standard
        let interests = defaults.string(forKey: interest_key)?.components(separatedBy: ",")
        return interests
    }
    
    
    /// updates the new username
    ///
    /// - Parameters:
    ///   - value: new value to update as String
    ///   - key: the identifier from the Keys as String
    static func updateUser(value : String)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: username_key)
    }
    
    /// returns the username when saved
    ///
    /// - Returns: username as String after saving
    static func getUser() -> String?
    {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: username_key)
    }
    
    
    /// updates the new token
    ///
    /// - Parameters:
    ///   - value: new value to update as String
    ///   - key: the identifier from the Keys as String
    static func updateToken(value : String)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: token_key)
    }
    
    /// returns the oauth token when saved
    ///
    /// - Returns: oauth token as String after saving
    static func getOauthToken() -> String?
    {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: token_key)
    }
    
    /// updates the new refresh token
    ///
    /// - Parameters:
    ///   - value: new value to update as String
    ///   - key: the identifier from the Keys as String
    static func updateRefreshToken(value : String)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: reftoken_key)
    }
    
    /// returns the oauth ref token when saved
    ///
    /// - Returns: oauth ref token as String after saving
    static func getRefreshToken() -> String?
    {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: reftoken_key)
    }
    
    /// updates the refreshDate
    ///
    /// - Parameters:
    ///   - value: new value to update as String
    ///   - key: the identifier from the Keys as String
    static func updateRefreshDate(value : String)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: refdate_key)
    }
    
    /// returns the oauth ref date when saved
    ///
    /// - Returns: oauth ref date as String after saving
    static func getRefreshDate() -> String?
    {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: refdate_key)
    }
    
    
    /// getToken retrieves the token through a closure callback using the code
    ///
    /// - Parameters:
    ///   - code: as String to be used in retrieving the token
    ///   - auth: as TokenRetrieve to return whether retrieving the token is successful or not
    static func getToken(code : String, auth : TokenRetrieve) {

        if let request = Config.requestForOAuth(code)
        {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                }
                let responseString = String(data: data, encoding: .utf8)
                if let responseString = responseString{
                    do {
                        let decoder = JSONDecoder()
                        let authToken = try decoder.decode(TokenResponse.self, from: data)
                        auth.didRetrieveToken!(authToken)
                    
                    } catch let err {
                        auth.didEncounterError!(ErrorCases.authError(), false)
                    }
                }
                else{
                    auth.didEncounterError!(ErrorCases.authError(), false)
                }
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        }
    }
    
    
    /// requestForRefresh to be used for the refreshin token process some parts of the code taken from redift
    ///
    /// - Parameter token: as String the token to be used to refresh the token
    /// - Returns: as URLRequest used for allocating the url request needed for sending requests to reddit server
    static func requestForRefresh(_ token: String) -> URLRequest? {
        guard let URL = URL(string: Config.baseAuthURL + "/api/v1/access_token") else { return nil }
        var request = URLRequest(url: URL)
        let param = "grant_type=refresh_token&refresh_token=" + token
        let data = param.data(using: .utf8)
        request.httpBody = data
        request.httpMethod = "POST"
        

        let password = ""
        let loginString = String(format: "%@:%@", Config.client_id, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue(Config.sharedInstance.userAgent, forHTTPHeaderField: "User-Agent")
        print(request)
        return request
    }
    
    
    /// requestForOAuth to be used for the oauth process some parts of the code taken from redift
    ///
    /// - Parameter code: as String the code to be used to end the oauth process
    /// - Returns: as URLRequest used for allocating the url request needed for sending requests to reddit server
    static func requestForOAuth(_ code: String) -> URLRequest? {
        guard let URL = URL(string: Config.baseAuthURL + "/api/v1/access_token") else { return nil }
        var request = URLRequest(url: URL)
        do {
            let param = "grant_type=authorization_code&code=" + code + "&redirect_uri=" + Config.redirect_uri
            let data = param.data(using: .utf8)
            request.httpBody = data
            request.httpMethod = "POST"
            let basicAuthenticationChallenge = Config.client_id + ":"
            if let data = basicAuthenticationChallenge.data(using: .utf8) {
                let base64Str = data.base64EncodedString(options: .lineLength64Characters)
                request.setValue("Basic " + base64Str, forHTTPHeaderField: "Authorization")
            }
            return request
        } catch {
            print(error)
            return nil
        }
    }
}
