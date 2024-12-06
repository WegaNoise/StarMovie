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
    func searchDataReceived(searchMovieList: [Movie]?)
    func closeSearch()
    func selectedMovie(index: IndexPath)
    func receivedError(error: NetworkErrors) async
}

final class SearchPagePresenter {
    weak var view: SearchPageViewProtocol?
    var router: SearchPageRouterProtocol
    var interactor: SearchPageInteractorProtocol
    var movies: [Movie]?
    var archiveMovieList: [Movie]?
    private let idPrimaryCategory = Resources.Genres.genreArray.first?.id.description

    init(interactor: SearchPageInteractorProtocol, router: SearchPageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPagePresenter: SearchPagePresenterProtocol {
    func viewDidLoad() {
        interactor.getMovieListInSelectedGenres(id: idPrimaryCategory ?? "18")
    }
    
    func changeSelectedGenres(id: Int) {
        view?.hideCollectionView(isHide: true)
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
        return movies?.element(at: index)
    }
    
    func updateMovieList(newList: [Movie]?) {
        self.movies = newList
        view?.newMovieListReceived()
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
        view?.hideCollectionView(isHide: true)
        interactor.searchMovieOnRequest(request: request)
    }
   
//methods that handle user actions when the user exits or ends the SearchTextField search
    func searchDataReceived(searchMovieList: [Movie]?) {
        if archiveMovieList == nil {
            self.archiveMovieList = self.movies
        }
        updateMovieList(newList: searchMovieList)
    }
    
    func closeSearch() {
        updateMovieList(newList: archiveMovieList ?? movies)
        archiveMovieList = nil
    }
    
    func selectedMovie(index: IndexPath) {
        guard let selectMovie = movies?[index.row] else { return }
        router.navigateToMovieDetails(movie: selectMovie)
    }
    
    func receivedError(error: NetworkErrors) async {
        let error = error as NetworkErrors
        await MainActor.run {
            view?.showOrHideErrorView(show: true, error: error)
        }
    }
}
