
//
//  MockAPIManager.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class MockAPIManager: APIManager {

    let responses = Responses()
    /// startAPI starts the api process for mock api process
    ///
    /// - Parameters:
    ///   - endPoint: as APIEndpoint to identify what type of endpoint will be requested
    ///   - input: as String the extra parameters to be ued in post or get requests
    ///   - isJson: as Bool whether the .json will be appended for public
    ///   - retrieved: as ErrorRetrieved the closure callback to be used in identifying whether the api process is ready to return results or error
    override func startAPI(endPoint : APIEndpoint, input : String?, isJson : Bool, retrieved : ErrorRetrieved) {
        if let data = responses.getResponsesFrom(apiEndpoint: endPoint).data(using: .utf8)
        {
            ClosureResults.apiResults(apiEndpoint: endPoint, data: data, retrieved: retrieved)
        }
    }
}
