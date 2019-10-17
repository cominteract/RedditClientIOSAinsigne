//
//  ChooseInterestPresenter.swift
//  RedditClientApp
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

/// ChooseInterestView protocol for updating the view in the view controllers
protocol ChooseInterestView: class {
  
}

/// ChooseInterestDelegate protocol for delegating implementations from the ChooseInterestServices
protocol ChooseInterestDelegate: class{
    
}

/// ChooseInterestPresenter protocol for implementing the ChooseInterestPresenter
protocol ChooseInterestPresenter {

}

/// ChooseInterestPresenter implementation based on the presenter protocol
class ChooseInterestPresenterImplementation : ChooseInterestPresenter, ChooseInterestDelegate {
    


    /// ChooseInterestView reference of the ChooseInterestViewController as ChooseInterestView type. Must be weak
    fileprivate weak var view: ChooseInterestView?
    
    /// ChooseInterestServices property to set the services used by the presenter
    var service : ChooseInterestServices!
    
    /// initializes with the ChooseInterestViewController as the ChooseInterestView for updating the view and authManager for consuming the authentication api and apiManager for consuming the api related to data
    ///
    /// - Parameters:
    ///   - view: ChooseInterestViewController as the ChooseInterestView for updating the view
    ///   - apiManager: for consuming the api related to data
    ///   - authManager: for consuming the authentication api
    init(view : ChooseInterestView,
         apiManager : APIManager, authManager : AuthManager) {
        service = ChooseInterestServices(apiManager : apiManager,
                                                    authManager : authManager)
        service.delegate = self
        self.view = view
    }
    
    
}
