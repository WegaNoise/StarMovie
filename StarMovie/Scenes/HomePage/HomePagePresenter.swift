//
//  HomePagePresenter.swift
//  StarMovie
//
//  Created by petar on 11.04.2024
//

import Foundation

protocol HomePagePresenterProtocol: AnyObject {
    var movies: [Movie]? { get }
    func viewDidLoad()
    func fetchPopularMovies(movies: [Movie]?)
    func returnMovieForIndex(index: Int) -> Movie?
    func selectMovie(index: IndexPath)
    func dataRetrievalError(error: NetworkErrors) async
}

final class HomePagePresenter {
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
    func viewDidLoad() {
        interactor.fetchDataMovie()
    }
    
    func fetchPopularMovies(movies: [Movie]?) {
        guard movies?.count != 0 else {
            view?.showErrorView(error: .invalidData)
            return }
        self.movies = movies
        view?.initializeCollectionView()
    }
    
    func returnMovieForIndex(index: Int) -> Movie? {
        return movies?.element(at: index)
    }
    
    func selectMovie(index: IndexPath) {
        guard let selectMovie = movies?[index.row] else { return }
        router.navigateToMovieDetails(movie: selectMovie)
    }
    
    func dataRetrievalError(error: NetworkErrors) async {
        await MainActor.run {
            view?.showErrorView(error: error)
        }
    }
}
