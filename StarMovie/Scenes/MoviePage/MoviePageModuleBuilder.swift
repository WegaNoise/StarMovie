//
//  MoviePageModuleBuilder.swift
//  Super easy dev
//
//  Created by petar on 22.06.2024
//

import UIKit

class MoviePageModuleBuilder {
    static func build() -> MoviePageViewController {
        let interactor = MoviePageInteractor()
        let router = MoviePageRouter()
        let presenter = MoviePagePresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "MoviePage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MoviePage") as! MoviePageViewController
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
