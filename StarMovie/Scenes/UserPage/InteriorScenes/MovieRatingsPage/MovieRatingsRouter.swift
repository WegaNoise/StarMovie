//
//  MovieRatingsRouter.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

protocol MovieRatingsRouterProtocol {
    func popViewController()
    func pushMoviePage(movie: Movie)
}

class MovieRatingsRouter: MovieRatingsRouterProtocol {
    weak var viewController: MovieRatingsViewController?
    
    func popViewController() {
        guard let viewController = viewController else { return }
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func pushMoviePage(movie: Movie) {
        guard let viewController = viewController else { return }
        let moviePage = MoviePageModuleBuilder.build(movie: movie)
        viewController.navigationController?.pushViewController(moviePage, animated: true)
    }
}

