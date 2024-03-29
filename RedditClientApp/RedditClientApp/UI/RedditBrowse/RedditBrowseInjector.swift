//
//  RedditBrowseInjector.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 16/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation


/// injector protocol template for injection of the services and data
protocol RedditBrowseInjector {
    func inject(viewController: RedditBrowseViewController)
}
/// injector implementation of the protocol template for injection
class RedditBrowseInjectorImplementation: RedditBrowseInjector {

    /// injects the RedditBrowseViewController generated with the services and the presenter used
    /// data
    /// - Parameter viewController: RedditBrowseViewController generated by the mvp template
    func inject(viewController: RedditBrowseViewController) {
     
 
        let data = DataInjector().getData()
        let services = ServicesInjector(data: data)
        let presenter = RedditBrowsePresenterImplementation(view: viewController, apiManager : services.getAPI() , authManager : services.getAuth())
        
        viewController.presenter = presenter
    }
}
