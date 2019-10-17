//
//  ErrorCases.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 13/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

class ErrorCases: NSObject {
    
    static func postError() -> NSError
    {
        let userInfo: [AnyHashable : Any] =
            [NSLocalizedDescriptionKey :  NSLocalizedString("PostError", value: "Something went wrong in submitting the post", comment: "") ,
             NSLocalizedFailureReasonErrorKey : NSLocalizedString("PostError", value: "SSomething went wrong in submitting the post", comment: "")]
        let err = NSError(domain: "PostError", code: 401, userInfo: userInfo as? [String : Any])
        return err
    }
    
    static func authError() -> NSError
    {
        let userInfo: [AnyHashable : Any] =
            [NSLocalizedDescriptionKey :  NSLocalizedString("AuthError", value: "Something went wrong in the authentication", comment: "") ,
             NSLocalizedFailureReasonErrorKey : NSLocalizedString("AuthError", value: "Something went wrong in the authentication", comment: "")]
        let err = NSError(domain: "AuthError", code: 401, userInfo: userInfo as? [String : Any])
        return err
    }
    
    /// returns error closure callback for showing the authentication error
    ///
    /// - Returns: closure callback to show the authentication error with the delegate
    func error(source : NSObject) -> ((Error, Bool) -> Void)? {
        return { [weak source]
            (error : Error, revoked : Bool ) -> Void in
        }
    }
}
