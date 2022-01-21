//
//  MoviesListModuleConfigurator.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 21.01.2022.
//

import Foundation

class MoviesListModuleConfigurator: ModuleConfigurator {
    typealias ViewControllerForConfigurationType = MoviesListViewController
    
    typealias InteractorType = MoviesListBusinessLogic & MoviesListDataStore
    typealias PresenterType = MoviesListPresentationLogic
    typealias RouterType = (NSObjectProtocol & MoviesListRoutingLogic & MoviesListDataPassing)
    
    var interactor: InteractorType
    var presenter: PresenterType
    var router: RouterType
    
    required init(interactor: InteractorType = MoviesListInteractor(), presenter: PresenterType = MoviesListPresenter(), router: RouterType = MoviesListRouter()) {
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
    }
    
    func module(configure viewController: ViewControllerForConfigurationType) {
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.viewController = viewController
        router.dataStore = interactor
    }
}
