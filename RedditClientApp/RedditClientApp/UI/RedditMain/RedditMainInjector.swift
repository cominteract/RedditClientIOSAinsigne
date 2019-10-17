//
//  RedditMainInjector.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 12/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//


import Foundation


/// injector protocol template for injection of the services and data
protocol RedditMainInjector {
    func inject(viewController: RedditMainViewController)
}
/// injector implementation of the protocol template for injection
class RedditMainInjectorImplementation: RedditMainInjector {

    /// injects the RedditMainViewController generated with the services and the presenter used
    /// data
    /// - Parameter viewController: RedditMainViewController generated by the mvp template
    func inject(viewController: RedditMainViewController) {
     
 
        let data = DataInjector().getData()
        let services = ServicesInjector(data: data)
        let presenter = RedditMainPresenterImplementation(view: viewController, apiManager : services.getAPI() , authManager : services.getAuth())
        
        viewController.presenter = presenter
    }
}