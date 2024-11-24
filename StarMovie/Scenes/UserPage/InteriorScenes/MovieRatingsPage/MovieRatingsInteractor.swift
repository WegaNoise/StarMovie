//
//  MovieRatingsInteractor.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

protocol MovieRatingsInteractorProtocol: AnyObject {
    func fetchMovieRatings()
    func findMovieByID(_ id: Int)
}

final class MovieRatingsInteractor: MovieRatingsInteractorProtocol {
    weak var presenter: MovieRatingsPresenterProtocol?
    private let coreDataManager = CoreDataManager.shared
    private let networkManager = NetworkManager.shared
    
    func fetchMovieRatings() {
        let ratingMovieList = coreDataManager.fatchRatedMovies()
        presenter?.uploadRatingMovieList(ratingMovieList)
    }
    
    func findMovieByID(_ id: Int) {
        Task {
            do {
                let movie = try await networkManager.searchMovieByID(id: id)
                await MainActor.run {
                    self.presenter?.presentMoviePage(movie: movie)
                }
            } catch let error{
                print(error.localizedDescription)
            }
        }
    }
}
