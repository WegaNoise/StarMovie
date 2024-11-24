//
//  WatchLaterRouter.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

protocol WatchLaterRouterProtocol {
    func popViewController()
    func showMoviePage(with movie: Movie)
}

final class WatchLaterRouter: WatchLaterRouterProtocol {
    weak var viewController: WatchLaterViewController?
    
    func popViewController() {
        guard let viewController = viewController else { return }
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func showMoviePage(with movie: Movie) {
        guard let viewController = viewController else { return }
        let moviePage = MoviePageModuleBuilder.build(movie: movie)
        viewController.navigationController?.pushViewController(moviePage, animated: true)
    }
}
