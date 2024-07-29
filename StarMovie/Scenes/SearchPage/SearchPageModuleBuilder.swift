//
//  SearchPageModuleBuilder.swift
//  Super easy dev
//
//  Created by petar on 17.04.2024
//

import UIKit

class SearchPageModuleBuilder {
    static func build() -> SearchPageViewController {
        let interactor = SearchPageInteractor()
        let router = SearchPageRouter()
        let presenter = SearchPagePresenter(interactor: interactor, router: router)
        let viewController = SearchPageViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
