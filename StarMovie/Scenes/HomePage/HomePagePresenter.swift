//
//  HomePagePresenter.swift
//  StarMovie
//
//  Created by petar on 11.04.2024
//

import Foundation

protocol HomePagePresenterProtocol: AnyObject {
    var movies: [Movie]? { get }
    func viewToReady()
    func getDataPopularMovie(movies: [Movie])
    func returnDataByMovie(index: Int) -> Movie?
    func selectMovie(index: IndexPath)
    func dataRetrievalError(error: NetworkErrors)
}

class HomePagePresenter {
    weak var view: HomePageViewProtocol?
    var router: HomePageRouterProtocol
    var interactor: HomePageInteractorProtocol
    var movies: [Movie]?

    
    init(interactor: HomePageInteractorProtocol, router: HomePageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomePagePresenter: HomePagePresenterProtocol {
    func viewToReady() {
        interactor.startLoadFormNetwork()
    }
    
    func getDataPopularMovie(movies: [Movie]){
        self.movies = movies
        view?.initializeCollectionView()
    }
    
    func returnDataByMovie(index: Int) -> Movie?{
        guard let movie = movies?[index] else { return nil }
        return movie
    }
    
    func selectMovie(index: IndexPath){
        guard let selectMovie = movies?[index.row] else { return }
        router.openMoviePage(movie: selectMovie)
    }
    
    func dataRetrievalError(error: NetworkErrors) {
        view?.showErrorView(error: error)
    }
}
