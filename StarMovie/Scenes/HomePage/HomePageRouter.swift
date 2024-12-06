//
//  HomePageRouter.swift
//  StarMovie
//
//  Created by petar on 11.04.2024
//

protocol HomePageRouterProtocol {
    func navigateToMovieDetails(movie: Movie)
}

class HomePageRouter: HomePageRouterProtocol {
    weak var viewController: HomePageViewController?
    
    func navigateToMovieDetails(movie: Movie){
        guard let viewController = viewController else { return }
        let moviePage = MoviePageModuleBuilder.build(movie: movie)
        viewController.navigationController?.pushViewController(moviePage, animated: true)
    }
}
