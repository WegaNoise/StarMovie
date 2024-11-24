//
//  MovieRatingsModuleBuilder.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

import UIKit

class MovieRatingsModuleBuilder {
    static func build() -> MovieRatingsViewController {
        let interactor = MovieRatingsInteractor()
        let router = MovieRatingsRouter()
        let presenter = MovieRatingsPresenter(interactor: interactor, router: router)
        let viewController = MovieRatingsViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
