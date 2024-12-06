//
//  MoviePageRouter.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//

protocol MoviePageRouterProtocol {
    func popViewController()
}

final class MoviePageRouter: MoviePageRouterProtocol {
    weak var viewController: MoviePageViewController?
    
    func popViewController(){
        guard let viewController else { return }
        viewController.navigationController?.popViewController(animated: true)
    }
}
