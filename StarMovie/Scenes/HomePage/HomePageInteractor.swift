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
                let movieList = try await shared.geMovieListForHomePage()
                await MainActor.run {
                    presenter?.getDataPopularMovie(movies: movieList)
                }
            } catch let error as NetworkErrors {
                presenter?.dataRetrievalError(error: error)
            } catch {
                presenter?.dataRetrievalError(error: .unknownError)
            }
        }
    }
}





