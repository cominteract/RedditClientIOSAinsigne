//
//  Rules.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
/// Rules used to get the list of rules about a certain subreddit
struct Rules : Decodable {
    let rules : [SubRules]?
}

struct SubRules : Decodable{
    let description : String?
}
