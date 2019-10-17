//
//  APIProtocol.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit



/// api protocol which is the template used in consuming the api with the mock api manager or the reddit api manager
protocol APIProtocol: class {
    
    /// startAPI starts the api process for the GET and POST requests in reddit api or for mock api process
    ///
    /// - Parameters:
    ///   - endPoint: as APIEndpoint to identify what type of endpoint will be requested
    ///   - input: as String the extra parameters to be ued in post or get requests
    ///   - isJson: as Bool whether the .json will be appended for public
    ///   - retrieved: as ErrorRetrieved the closure callback to be used in identifying whether the api process is ready to return results or error
    func startAPI(endPoint : APIEndpoint, input : String?, isJson : Bool, retrieved : ErrorRetrieved)
    
}
