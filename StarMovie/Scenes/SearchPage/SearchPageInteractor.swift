//
//  SearchPageInteractor.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

protocol SearchPageInteractorProtocol: AnyObject {
    func getMovieListInSelectedGenres(id: String)
    func searchMovieOnRequest(reqest: String)
}

class SearchPageInteractor: SearchPageInteractorProtocol {
  
    weak var presenter: SearchPagePresenterProtocol?
    let networkManager = NetworkManager.shared
    
    func getMovieListInSelectedGenres(id: String) {
        networkManager.getMovieListInGenre(genereID: id) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let movies):
                presenter?.receivedMovieList(movieList: movies)
            case .failure(let error):
                presenter?.receivedError(error: error as! NetworkErrors)
                print(error.localizedDescription)
            }
        }
    }
    
    func searchMovieOnRequest(reqest: String) {
        networkManager.searhMovie(query: reqest) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let foundMovies):
                presenter?.searchDataReceived(searchMovieList: foundMovies)
            case .failure(let error):
                presenter?.receivedError(error:  error as! NetworkErrors)
                print(error.localizedDescription)
            }
        }
    }
}
