//
//  SearchPageRouter.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

protocol SearchPageRouterProtocol {
    func openMoviePage(movie: Movie)
}

class SearchPageRouter: SearchPageRouterProtocol {
    weak var viewController: SearchPageViewController?
    
    func openMoviePage(movie: Movie){
        let moviePage = MoviePageModuleBuilder.build(movie: movie)
        viewController?.navigationController?.pushViewController(moviePage, animated: true)
    }
}
