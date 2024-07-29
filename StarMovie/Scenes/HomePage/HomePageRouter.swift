//
//  HomePageRouter.swift
//  Super easy dev
//
//  Created by petar on 11.04.2024
//

protocol HomePageRouterProtocol {
    func openMoviePage(movie: Movie)
}

class HomePageRouter: HomePageRouterProtocol {
    weak var viewController: HomePageViewController?
    
    func openMoviePage(movie: Movie){
        let moviePage = MoviePageModuleBuilder.build(movie: movie)
        viewController?.navigationController?.pushViewController(moviePage, animated: true)
    }
}
