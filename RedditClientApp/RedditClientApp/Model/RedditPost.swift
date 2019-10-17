


//
//  RedditPost.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 14/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditPost used in identifying whether the response is successful through matching the response
struct RedditPost: Decodable {
    var json : RedditPostJsonResponse?
}
struct RedditPostJsonResponse: Decodable
{
    var errors : [RedditPostError]?
    var url : String?
}

struct RedditPostError : Decodable
{
    var ars : String
}
