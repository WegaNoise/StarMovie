//
//  HomePageInteractor.swift
//  StarMovie
//
//  Created by petar on 11.04.2024
//

import Foundation

protocol HomePageInteractorProtocol: AnyObject {
    func startLoadFormNetwork()
}

class HomePageInteractor: HomePageInteractorProtocol {
    
    weak var presenter: HomePagePresenterProtocol?
    let sharedApi = NetworkManager.shared
    
    func startLoadFormNetwork() {
        sharedApi.getPopularMovieList { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let movies):
                presenter?.getDataPopularMovie(movies: movies)
            case .failure(let error):
                presenter?.dataRetrievalError(error: error as! NetworkErrors)
                print(error.localizedDescription)
            }
        }
    }
}





