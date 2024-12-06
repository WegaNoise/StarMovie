//
//  SearchPageRouter.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

protocol SearchPageRouterProtocol {
    func navigateToMovieDetails(movie: Movie)
}

class SearchPageRouter: SearchPageRouterProtocol {
    weak var viewController: SearchPageViewController?
    
    func navigateToMovieDetails(movie: Movie){
        guard let viewController = viewController else { return }
        let moviePage = MoviePageModuleBuilder.build(movie: movie)
        viewController.navigationController?.pushViewController(moviePage, animated: true)
    }
}
