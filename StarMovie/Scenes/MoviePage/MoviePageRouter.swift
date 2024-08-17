//
//  MoviePageRouter.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//

protocol MoviePageRouterProtocol {
    func goOutMoviePage()
}

class MoviePageRouter: MoviePageRouterProtocol {
    weak var viewController: MoviePageViewController?
    
    func goOutMoviePage(){
        viewController?.navigationController?.popViewController(animated: true)
    }
}
