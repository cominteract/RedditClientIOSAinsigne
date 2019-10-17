//
//  RedditOAuthViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit
import WebKit
/// RedditOAuthViewController as RedditOAuthView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditOAuthViewController : BaseViewController, RedditOAuthView {
    
    /// presenter as RedditOAuthPresenter injected automatically to call implementations
    var presenter: RedditOAuthPresenter!
    
    /// injector as RedditOAuthInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditOAuthInjectorImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        injector.inject(viewController: self)
        
        //presenter.startAuth()
        Config.appDelegate.openMain()
    }
    
    /// authTokenErrorView when retrieving token fails update the view
    func authTokenErrorUpdateView() {
        print("Token Error")
    }
    
    /// authTokenUpdateView when retrieving token is successful update the view
    func authTokenUpdateView() {
        Config.appDelegate.openMainStart()
        
    }
}
