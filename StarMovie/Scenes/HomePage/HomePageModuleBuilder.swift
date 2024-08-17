//
//  HomePageModuleBuilder.swift
//  StarMovie
//
//  Created by petar on 11.04.2024
//

import UIKit

class HomePageModuleBuilder {
    static func build() -> HomePageViewController {
        let interactor = HomePageInteractor()
        let router = HomePageRouter()
        let presenter = HomePagePresenter(interactor: interactor, router: router)
        let viewController = HomePageViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
