//
//  MovieRatingsPresenter.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//
import Foundation

protocol MovieRatingsPresenterProtocol: AnyObject {
    var movieRatingList: [MovieEntity] { get }
    func viewDidLoad()
    func uploadRatingMovieList(_ movieList: [MovieEntity])
    func pressBeckButtton()
    func movieByIndexPath(_ index: IndexPath) -> MovieEntity
    func didSelectMovie(_ index: IndexPath)
    func presentMoviePage(movie: Movie?)
    func movieListUpdate()
}

final class MovieRatingsPresenter {
    weak var view: MovieRatingsViewProtocol?
    private var router: MovieRatingsRouterProtocol
    private var interactor: MovieRatingsInteractorProtocol
    var movieRatingList: [MovieEntity] = []
    private var updateFlag: Bool = false

    init(interactor: MovieRatingsInteractorProtocol, router: MovieRatingsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MovieRatingsPresenter: MovieRatingsPresenterProtocol {
    func viewDidLoad() {
        interactor.fetchMovieRatings()
    }
    
    func uploadRatingMovieList(_ movieList: [MovieEntity]) {
        self.movieRatingList = movieList
        guard movieRatingList.count != 0  else { view?.ratingMovieNotFound()
            return }
        if updateFlag == true {
            view?.updatedDataCollectionView()
            return
        }
        view?.showRatingCollectionView()
        updateFlag = true
    }
    
    func movieListUpdate() {
        interactor.fetchMovieRatings()
    }
    
    func pressBeckButtton() {
        router.popViewController()
    }
    
    func movieByIndexPath(_ index: IndexPath) -> MovieEntity{
        return movieRatingList[index.row]
    }
    
    func didSelectMovie(_ index: IndexPath) {
        let movieID = Int(movieRatingList[index.row].id)
        interactor.findMovieByID(movieID)
    }
    
    func presentMoviePage(movie: Movie?) {
        guard let movie else { return }
        router.pushMoviePage(movie: movie)
    }
}
