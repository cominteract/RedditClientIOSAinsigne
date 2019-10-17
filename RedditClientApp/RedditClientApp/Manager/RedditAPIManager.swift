//
//  RedditAPIManager.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class RedditAPIManager: APIManager {
    
    /// getPostField returns the post type
    ///
    /// - Returns: as String the post type to be used as parameter in sending POST Requests via submit endpoint
    func getPostField() -> String
    {
        switch postType {
        case .Image, .Video:
            return "media"
        case .Text:
            return "self"
        default:
            return "url"
        }
    }
    
    /// paramToJson converts a delimited comma String into an array of Dictionaries to be used as parameters
    ///
    /// - Parameter params: as String the comma delimited String
    /// - Returns: as [String:String] to be used as parameters
    func paramToJson(params : String) -> [String:String]?{
        let fields = ["api_type","kind","resubmit","sendreplies","sr","title",getPostField()]
        var parameters = [String:String]()
        guard params.components(separatedBy: ",").count == 7 else {
            return nil
        }
        for i in 0..<params.components(separatedBy: ",").count {
            parameters[fields[i]] = params.components(separatedBy: ",")[i]
        }
        let parameter = [
            "api_type": "json",
            "kind": "link",
            "resubmit": "true",
            "sendreplies": "true",
            "sr": "programming",
            "title": "sel",
            "url": "http://github.com/reddit/reddit"
        ]
        return parameters
    }
    
    /// startAPI starts the api process for the GET and POST requests in reddit api
    ///
    /// - Parameters:
    ///   - endPoint: as APIEndpoint to identify what type of endpoint will be requested
    ///   - input: as String the extra parameters to be ued in post or get requests
    ///   - isJson: as Bool whether the .json will be appended for public
    ///   - retrieved: as ErrorRetrieved the closure callback to be used in identifying whether the api process is ready to return results or error
    override func startAPI(endPoint : APIEndpoint, input : String?, isJson : Bool, retrieved : ErrorRetrieved) {
        let endpointString = EndPoints.endpoint(endpoint: endPoint, input: input)
        var request : URLRequest?
        let method = EndPoints.method(endpoint: endPoint)
        if !isJson{
            request = URLRequest(url: URL(string: "\(Config.baseAPIURL)\(endpointString)")!)
            if method == "POST", let input = input{
                if let parameter = paramToJson(params: input){
                    request?.httpBody = parameter.URLQuery.data(using: .utf8)
                }
            }
            if let authToken = Config.getOauthToken(){
                request?.addValue("bearer \(authToken)", forHTTPHeaderField: "Authorization")
            }
        }
        else{
            if endPoint != APIEndpoint.Default{
                request = URLRequest(url: URL(string: "\(Config.baseAuthURL)\(endpointString).json")!)
            }
            else{
                request = URLRequest(url: URL(string: EndPoints.endpoint(endpoint: APIEndpoint.Default, input:
                nil))!)
            }
        }
        request?.httpMethod = method
        print(" \(request) ")
        request?.addValue(Config.sharedInstance.userAgent, forHTTPHeaderField: "User-Agent")
        let task = URLSession.shared.dataTask(with: request!) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print(" \r\n\n \(endPoint) ---  \(endpointString) responseString = \(String(describing: responseString)) \r\n\n ")
            ClosureResults.apiResults(apiEndpoint: endPoint, data: data, retrieved: retrieved)
            return
        }
        task.resume()
    }
}
