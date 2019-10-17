//
//  RedditAboutInjector.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 15/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation


/// injector protocol template for injection of the services and data
protocol RedditAboutInjector {
    func inject(viewController: RedditAboutViewController)
}
/// injector implementation of the protocol template for injection
class RedditAboutInjectorImplementation: RedditAboutInjector {

    /// injects the RedditAboutViewController generated with the services and the presenter used
    /// data
    /// - Parameter viewController: RedditAboutViewController generated by the mvp template
    func inject(viewController: RedditAboutViewController) {
     
 
        let data = DataInjector().getData()
        let services = ServicesInjector(data: data)
        let presenter = RedditAboutPresenterImplementation(view: viewController, apiManager : services.getAPI() , authManager : services.getAuth())
        
        viewController.presenter = presenter
    }
}