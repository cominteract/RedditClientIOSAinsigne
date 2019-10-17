//
//  RedditAuthSignViewController.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import UIKit

/// RedditAuthSignViewController as RedditAuthSignView to be updated by the presenter after an implementation, BaseViewController for common methods and properties if ever (extensions etc)

class RedditAuthSignViewController : BaseViewController, RedditAuthSignView {
    
    /// presenter as RedditAuthSignPresenter injected automatically to call implementations
    var presenter: RedditAuthSignPresenter!
    
    /// injector as RedditAuthSignInjector injects the presenter with the services and data needed for the implementation
    var injector = RedditAuthSignInjectorImplementation()
    
 
    @IBAction func loginClicked(_ sender: Any) {
        presenter.startAuth()
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        injector.inject(viewController: self)
        
    }

    /// authTokenErrorView when retrieving token fails update the view
    func authTokenErrorUpdateView() {
        print("Token Error")
    }
    
    /// authTokenUpdateView when retrieving token is successful update the view
    func authTokenUpdateView() {
        print("Token Success")
        
    }
  
}
