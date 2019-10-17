//
//  RedditDetailCommentsInjector.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation


/// injector protocol template for injection of the services and data
protocol RedditDetailCommentsInjector {
    func inject(viewController: RedditDetailCommentsViewController)
}
/// injector implementation of the protocol template for injection
class RedditDetailCommentsInjectorImplementation: RedditDetailCommentsInjector {

    /// injects the RedditDetailCommentsViewController generated with the services and the presenter used
    /// data
    /// - Parameter viewController: RedditDetailCommentsViewController generated by the mvp template
    func inject(viewController: RedditDetailCommentsViewController) {
     
 
        let data = DataInjector().getData()
        let services = ServicesInjector(data: data)
        let presenter = RedditDetailCommentsPresenterImplementation(view: viewController, apiManager : services.getAPI() , authManager : services.getAuth())
        
        viewController.presenter = presenter
    }
}