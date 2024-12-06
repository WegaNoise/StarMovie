//
//  MoviePageInteractor.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//
import Foundation

protocol MoviePageInteractorProtocol: AnyObject {
    func getMovieDetails(_ movie: Movie)
    func addMovieToWatchlist(movie: Movie)
    func removeMovieFromWatchlist(movie: Movie)
    func changeMovieRating(movie: Movie, rating: Int)
}

final class MoviePageInteractor: MoviePageInteractorProtocol {
    weak var presenter: MoviePagePresenterProtocol?
    private let sharedApi = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    func getMovieDetails(_ movie: Movie) {
        let entity = coreDataManager.fetchMovieByID(movie.id)
        let dateFormatter = DateFormatter()
        Task {
            do {
                let posterData = try await sharedApi.getImageForMovie(imageLink: movie.posterPath ?? "")
                let trailerID = try await sharedApi.getYouTubeTrailer(filmName: movie.title ?? "",
                                                                      filmYear: dateFormatter.onlyYearString(from: movie.releaseDate ?? Date()))
                let movieDatails = MovieDetails(posterData: posterData,
                                                userRating: Int(entity?.userRating ?? 0),
                                                watchLater: entity?.watchLater ?? false,
                                                trailerID: trailerID)
                await MainActor.run {
                    presenter?.configMovieItem(movieDetails: movieDatails)
                }
            } catch {
                await MainActor.run {
                    presenter?.failedMovieConfiguration(error: error as? NetworkErrors ?? .unknownError)
                }
            }
        }
    }
    
    func addMovieToWatchlist(movie: Movie) {
        coreDataManager.addMovieToWatchLater(movie: movie)
    }
    
    func removeMovieFromWatchlist(movie: Movie) {
        coreDataManager.removeMovieFromWatchLater(movie: movie)
    }
    
    func changeMovieRating(movie: Movie, rating: Int) {
        coreDataManager.updateMovieRating(movie: movie, newRating: rating)
    }
}
