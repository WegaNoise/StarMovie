//
//  SearchPagePresenter.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

protocol SearchPagePresenterProtocol: AnyObject {
    var movies: [Movie]? { get }
    var arhiveMovieList: [Movie]? { get }
    func viewDidLoad()
    func changeSelectedGenres(id: Int)
    func receivedMovieList(movieList: [Movie])
    func returnDataByMovie(index: Int) -> Movie?
    func gettingUserSearchRequest(request: String)
    func searchDataReceived(searchMovieList: [Movie])
    func closeSearch()
}

final class SearchPagePresenter {
    weak var view: SearchPageViewProtocol?
    var router: SearchPageRouterProtocol
    var interactor: SearchPageInteractorProtocol
    var movies: [Movie]?
    var arhiveMovieList: [Movie]?

    init(interactor: SearchPageInteractorProtocol, router: SearchPageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPagePresenter: SearchPagePresenterProtocol {
    func viewDidLoad() {
        interactor.getMovieListInSelectedGenres(id: "18")
    }
    
    func changeSelectedGenres(id: Int) {
        interactor.getMovieListInSelectedGenres(id: id.description)
    }
    
    func receivedMovieList(movieList: [Movie]) {
        guard movies != nil else {
            self.movies = movieList
            view?.initializeCollectionView()
            return }
        self.movies = movieList
        view?.newMovieListReceived()
    }
    
    func returnDataByMovie(index: Int) -> Movie? {
        guard let movie = movies?[index] else { return nil }
        return movie
    }
    
    func gettingUserSearchRequest(request: String) {
        interactor.searchMovieOnRequest(reqest: request)
    }
    
    func searchDataReceived(searchMovieList: [Movie]) {
        if arhiveMovieList != nil {
            self.arhiveMovieList = self.movies
            self.movies = searchMovieList
            view?.newMovieListReceived()
        } else {
            self.movies = searchMovieList
            view?.newMovieListReceived()
        }
    }
    
    func closeSearch() {
        guard arhiveMovieList != nil else {
            view?.newMovieListReceived()
            return }
        self.movies = self.arhiveMovieList
        view?.newMovieListReceived()
    }
}
