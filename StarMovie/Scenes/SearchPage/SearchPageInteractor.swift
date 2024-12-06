//
//  SearchPageInteractor.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

protocol SearchPageInteractorProtocol: AnyObject {
    func getMovieListInSelectedGenres(id: String)
    func searchMovieOnRequest(request: String)
}

final class SearchPageInteractor: SearchPageInteractorProtocol {
  
    weak var presenter: SearchPagePresenterProtocol?
    private let networkManager = NetworkManager.shared
    
    func getMovieListInSelectedGenres(id: String) {
        Task {
            do {
                let foundMovies = try await networkManager.getMovieListInGenre(genereID: id)
                await MainActor.run {
                    presenter?.receivedMovieList(movieList: foundMovies)
                }
            } catch {
                await presenter?.receivedError(error: error as? NetworkErrors ?? .unknownError)
            }
        }
    }
    
    
    func searchMovieOnRequest(request: String) {
        Task {
            do {
                let foundMovies = try await networkManager.searhMovieList(query: request)
                await MainActor.run {
                    presenter?.searchDataReceived(searchMovieList: foundMovies)
                }
            } catch let error{
                await presenter?.receivedError(error: error as? NetworkErrors ?? .unknownError)
            }
        }
    }
}
