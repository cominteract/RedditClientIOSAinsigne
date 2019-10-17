//
//  RedditPostActionServices.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 14/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation





/// RedditPostActionServices class for implementing the services needed for the presenter
class RedditPostActionServices: NSObject {

    /// delegate for the implementation of the template generated RedditPostActionServices
    weak var delegate : RedditPostActionDelegate?
    
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
    
    
    /// postSuccess returns the closure callback to determine whether sending post request is successful or not
    ///
    /// - Returns: as postSuccess the closure callback
    func postSuccess() -> PostSuccess
    {
        let retrieved = PostSuccess()
        retrieved.didRetrievedPost = {
            (message : String, endPoint : APIEndpoint) in
            print("Message \(message)")
            self.delegate?.postedSuccessfully(message: message)
            
        }
        retrieved.didRetrievedError = {
            (error : Error, revoked : Bool) in
            print("Message \(error.localizedDescription)")
            self.delegate?.errorPosted(message: error.localizedDescription)
            
        }
        return retrieved
    }
    
    
    /// sendText submits the text or link api request using the service connected to api manager using the closure callback PostSuccess
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to submit
    ///   - text: as String the content of the post to submit
    ///   - sr: as  String the subreddit to post the message or link to
    ///   - postType: as PostType to identify whether it is a link or text
    func sendText(title : String, text: String, sr : String, postType : PostType)
    {
        let params = "json,self,true,true,\(sr),\(title),\(text)"
        apiManager.postType = postType
        self.apiManager.startAPI(endPoint: APIEndpoint.SubmitLink, input: params, isJson: false, retrieved: postSuccess() )
    }
    
    /// sendLink submits the text or link api request using the service connected to api manager using the closure callback PostSuccess
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to submit
    ///   - url: as String the content of the post to submit
    ///   - sr: as  String the subreddit to post the message or link to
    ///   - postType: as PostType to identify whether it is a link or text
    
    func sendLink(title : String, url : String, sr : String, postType : PostType)
    {
        let params = "json,link,true,true,\(sr),\(title),\(url)"
        apiManager.postType = postType
        self.apiManager.startAPI(endPoint: APIEndpoint.SubmitLink, input: params, isJson: false, retrieved: postSuccess() )
    }
    
    /// sendVideo submits the image or video api request using the service connected to api manager using the closure callback PostSuccess
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to submit
    ///   - text: as String the content of the post to submit
    ///   - sr: as  String the subreddit to post the image or video to
    ///   - postType: as PostType to identify whether it is a image or video
    func sendVideo(title : String, data : Data, sr : String, postType : PostType)
    {
        
        //let params = "json,video,true,true,\(sr),\(data),\(url)"
        //self.apiManager.startAPI(endPoint: APIEndpoint.SubmitLink, input: params, isJson: false, retrieved: postSuccesss() )
    }
    
    /// sendImage submits the image or video api request using the service connected to api manager using the closure callback PostSuccess
    ///
    /// - Parameters:
    ///   - title: as String the title of the post to submit
    ///   - text: as String the content of the post to submit
    ///   - sr: as  String the subreddit to post the image or video to
    ///   - postType: as PostType to identify whether it is a image or video
    func sendImage(title : String, data : Data, sr : String, postType : PostType)
    {
        //let params = "json,image,true,true,\(sr),\(data),\(url)"
        // self.apiManager.startAPI(endPoint: APIEndpoint.SubmitLink, input: params, isJson: false, retrieved: postSuccesss() )
    }
}
