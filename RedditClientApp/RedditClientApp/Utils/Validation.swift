//
//  Validation.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 17/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// input validation class to either to return the error message from the validation error through closure callback and the closure to return the validation message when the validation succeeded if applicable
class InputValidation
{
    var didInputValid : (((String, String)) -> Void)?
    var didInputInvalidWithError : (((String, String)) -> Void)?
}
/// class for validating the input
class Validation: NSObject {
    
    /// checks if it is a validated url
    ///
    /// - Parameter text: text input to be validated if it is email as String
    /// - Returns: the flag whether the email pattern validation is successful or not as Bool
    func isUrl(text : String) -> Bool
    {
        let pattern = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let check = NSPredicate(format:"SELF MATCHES %@", pattern)
        return check.evaluate(with: text)
    }
    
    /// isValidUrl input validation for url for submit post link
    ///
    /// - Parameters:
    ///   - text: as text to identify if valid url
    ///   - inputValidation: closure callback to return validation message is succeeded or validation error if not as InputValidation
    func isValidUrl(text : String, inputValidation : InputValidation)
    {
        if isUrl(text: text)
        {
            inputValidation.didInputValid!(("Success","Validation success"))
        }
        else
        {
            inputValidation.didInputInvalidWithError!(("Error","Validation error"))
        }
    }
}

