//
//  SearchPagePresenter.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

import Foundation

protocol SearchPagePresenterProtocol: AnyObject {
    var movies: [Movie]? { get }
    func viewDidLoad()
    func changeSelectedGenres(id: Int)
    func receivedMovieList(movieList: [Movie])
    func returnDataByMovie(index: Int) -> Movie?
    func textFielddidBeginEditing()
    func textFieldShouldReturn(text: String)
    func textFieldShouldClear()
    func searchUserMovieData(request: String)
    func searchDataReceived(searchMovieList: [Movie])
    func closeSearch()
    func selectedMovie(index: IndexPath)
    func receivedError(error: NetworkErrors)
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
        view?.hideCollectionVeiw(isHide: true)
        interactor.getMovieListInSelectedGenres(id: id.description)
    }
    
    func receivedMovieList(movieList: [Movie]) {
        if movies == nil {
            self.movies = movieList
            view?.initializeCollectionView()
        } else {
            self.movies = movieList
            view?.newMovieListReceived()
        }
    }
    
    func returnDataByMovie(index: Int) -> Movie? {
        guard let movie = movies?[index] else { return nil }
        return movie
    }

//methods processing user actions with SearchTextField(UITextField)
    func textFielddidBeginEditing() {
        view?.hideHorizontalMenu()
    }
    
    func textFieldShouldReturn(text: String) {
        guard text.isEmpty == true else { return }
        view?.showHorizontalMenu()
        closeSearch()
    }
    
    func textFieldShouldClear() {
        view?.showHorizontalMenu()
        closeSearch()
    }
    
    func searchUserMovieData(request: String) {
        guard request.count >= 2 else { return }
        view?.hideCollectionVeiw(isHide: true)
        interactor.searchMovieOnRequest(reqest: request)
    }
   
//methods that handle user actions when the user exits or ends the SearchTextField search
    func searchDataReceived(searchMovieList: [Movie]) {
        if arhiveMovieList == nil {
            self.arhiveMovieList = self.movies
            self.movies = searchMovieList
            view?.newMovieListReceived()
        } else {
            self.movies = searchMovieList
            view?.newMovieListReceived()
        }
    }
    
    func closeSearch() {
        if arhiveMovieList != nil {
            self.movies = self.arhiveMovieList
            self.arhiveMovieList = nil
            view?.newMovieListReceived()
        } else {
            view?.newMovieListReceived()
        }
    }
    
    func selectedMovie(index: IndexPath) {
        guard let selectMovie = movies?[index.row] else { return }
        router.openMoviePage(movie: selectMovie)
    }
    
    func receivedError(error: NetworkErrors) {
        view?.showOrHideErrorView(show: true, error: error)
    }
}
