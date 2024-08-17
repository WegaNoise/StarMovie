//
//  MoviePageInteractor.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//
import Foundation

protocol MoviePageInteractorProtocol: AnyObject {
    var movie: Movie { get }
    func getTrailerID()
}

class MoviePageInteractor: MoviePageInteractorProtocol {
    weak var presenter: MoviePagePresenterProtocol?
    let movie: Movie
    let sharedApi = NetworkManager.shared
    
    init(movie: Movie){
        self.movie = movie
        
    }
    
    func getTrailerID() {
        sharedApi.getYouTubeTrailer(filmName: movie.title ?? "film movie") { [weak self] result  in
            guard let self = self else { return }
                switch result {
                case .success(let videoID):
                    self.presenter?.getTrailerID(id: videoID.videoID)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
