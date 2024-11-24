//
//  WatchLaterInteractor.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

protocol WatchLaterInteractorProtocol: AnyObject {
    func fetchWatchLaterMovies()
    func changeIsWatchedState(movie: MovieEntity)
    func findMovieByID(_ id: Int)
}

final class WatchLaterInteractor: WatchLaterInteractorProtocol {
    weak var presenter: WatchLaterPresenterProtocol?
    private let coreDataManager = CoreDataManager.shared
    private lazy var networkManager = NetworkManager.shared
    
    
    func fetchWatchLaterMovies() {
        let movieList = coreDataManager.fatchWatchLaterMovies()
        presenter?.uploadedWatchLaterMovies(movieList)
    }
    
    func changeIsWatchedState(movie: MovieEntity) {
        coreDataManager.changePropertyIsWatched(movie: movie)
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
