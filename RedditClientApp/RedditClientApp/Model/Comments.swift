//
//  ViewCount.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// Comments used to get the list of comments from a certain subreddit post
struct Comments: Codable
{
    var data : CommentsData?
    var kind : String?
}


struct CommentsData : Codable
{

    var children : [CommentsChildren]?
    func encode(to encoder: Encoder) throws {
        
    }
}

struct CommentsChildren : Decodable
{
    var data : CommentsChildrenData?
 
}

struct CommentsChildrenData : Decodable
{

    var body : String?
    var utc_created : Double?
    var subreddit : String?
    var selftext : String?
    var subreddit_name_prefixed : String?
    var ups : Int?
    var id : String?
    var author : String?
    var created_utc : Double?
    var subreddit_subscribers : Int?
    var num_comments : Int?
    var total_awards_received : Int?
    //var children : [CommentsChildren]?

    // var replies : CommentReplies?
    // var replies : ReplyData?
    var link_id : String?
    var replies : Replies?
}




struct Replies : Decodable
{
    var kind : String?
    let isEdited: Bool
    var test1 : String?
    var data : CommentsData?
    // Where we determine what type the value is
    init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()
        
        // Check for a boolean
        do {
            test1 = try container.decode(String.self)
            isEdited = false

        } catch {
            // Check for an integer
            data = try container.decode(CommentsData.self)
            isEdited = true
        }
    }
    
    
    // We need to go back to a dynamic type, so based on the data we have stored, encode to the proper type
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try isEdited ? container.encode(data) : container.encode(test1)
    }
}
