//
//  MoviePageModuleBuilder.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//

import UIKit

class MoviePageModuleBuilder {
    static func build(movie: Movie) -> MoviePageViewController {
        let interactor = MoviePageInteractor()
        let router = MoviePageRouter()
        let presenter = MoviePagePresenter(interactor: interactor, router: router, movie: movie)
        let viewController = MoviePageViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
