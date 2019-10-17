//
//  TokenResponse.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// Token response for allocating the keys from the decodable json when accesing tokens
public struct TokenResponse: Codable {
    let token_type : String
    let access_token : String
    let expires_in : Int
    let refresh_token : String?
}
