//
//  HomePageInteractor.swift
//  StarMovie
//
//  Created by petar on 11.04.2024
//

import Foundation

protocol HomePageInteractorProtocol: AnyObject {
    func fetchDataMovie()
}

final class HomePageInteractor: HomePageInteractorProtocol {
    
    weak var presenter: HomePagePresenterProtocol?
    private let shared = NetworkManager.shared
    
    func fetchDataMovie() {
        Task {
            do {
                let movieList = try await shared.getMovieListForHomePage()
                await MainActor.run {
                    presenter?.fetchPopularMovies(movies: movieList)
                }
            } catch {
                await presenter?.dataRetrievalError(error: error as? NetworkErrors ?? .unknownError)
            }
        }
    }
}





