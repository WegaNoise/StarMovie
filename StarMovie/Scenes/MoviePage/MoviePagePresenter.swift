//
//  MoviePagePresenter.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//
import Foundation

protocol MoviePagePresenterProtocol: AnyObject {
    var movie: Movie { get }
    func configMovieItem(movieDetails: MovieDetails)
    func pressBeckButtton()
    func viewDidLoad()
    func pressedButtonAddLibrary()
    func receivedNewStarsValue(newValue: Int)
    func failedMovieConfiguration(error: NetworkErrors)
}

final class MoviePagePresenter {
    weak var view: MoviePageViewProtocol?
    var router: MoviePageRouterProtocol
    var interactor: MoviePageInteractorProtocol
    var movie: Movie
    
    init(interactor: MoviePageInteractorProtocol, router: MoviePageRouterProtocol, movie: Movie) {
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }
}

extension MoviePagePresenter: MoviePagePresenterProtocol {
    func viewDidLoad() {
        interactor.getMovieDetails(movie)
    }
    
    func configMovieItem(movieDetails: MovieDetails) {
        movie.posterData = movieDetails.posterData
        movie.userRating = movieDetails.userRating
        movie.watchLater = movieDetails.watchLater
        movie.trailerID = movieDetails.trailerID
        view?.startShowData()
    }
    
    func failedMovieConfiguration(error: NetworkErrors) {
        view?.showErrorView(error: error)
    }
    
    func pressBeckButtton() {
        router.popViewController()
    }
    
    func pressedButtonAddLibrary() {
        guard let watchLater = movie.watchLater else { return }
        movie.watchLater = !watchLater
        switch watchLater {
        case true :
            interactor.removeMovieFromWatchlist(movie: movie)
            view?.changeAddInLibraryButton(inLibrary: false)
        case false:
            interactor.addMovieToWatchlist(movie: movie)
            view?.changeAddInLibraryButton(inLibrary: true)
        }
    }
    
    func receivedNewStarsValue(newValue: Int) {
        interactor.changeMovieRating(movie: movie, rating: newValue)
    }
}
