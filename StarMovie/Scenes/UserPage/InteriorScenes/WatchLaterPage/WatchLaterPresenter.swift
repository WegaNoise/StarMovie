//
//  WatchLaterPresenter.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

protocol WatchLaterPresenterProtocol: AnyObject {
    var movieList: [MovieEntity] { get }
    func viewDidLoad()
    func pressBeckButtton()
    func uploadedWatchLaterMovies(_ movies: [MovieEntity])
    func pressedIsWatchedCheckbox(_  indexCell: Int)
    func selectedMovie(_ index: Int)
    func presentMoviePage(movie: Movie?)
}

final class WatchLaterPresenter {
    weak var view: WatchLaterViewProtocol?
    var router: WatchLaterRouterProtocol
    var interactor: WatchLaterInteractorProtocol
    var movieList: [MovieEntity] = []
    
    init(interactor: WatchLaterInteractorProtocol, router: WatchLaterRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension WatchLaterPresenter: WatchLaterPresenterProtocol {
    func viewDidLoad() {
        interactor.fetchWatchLaterMovies()
    }
    
    func uploadedWatchLaterMovies(_ movies: [MovieEntity]) {
        movieList = movies
        guard movieList.count != 0 else { view?.showNotFoundView()
            return }
        view?.showWatchLaterCollectionView()
    }
    
    func pressBeckButtton() {
        router.popViewController()
    }
    
    func pressedIsWatchedCheckbox(_  indexCell: Int) {
        let movie = movieList[indexCell]
        interactor.changeIsWatchedState(movie: movie)
    }
    
    func selectedMovie(_ index: Int) {
        let movieId = movieList[index].id
        interactor.findMovieByID(Int(movieId))
    }
    
    func presentMoviePage(movie: Movie?) {
        guard let movie else { return }
        router.showMoviePage(with: movie)
    }
}

