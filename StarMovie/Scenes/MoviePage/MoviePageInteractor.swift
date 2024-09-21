//
//  MoviePageInteractor.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//
import Foundation

protocol MoviePageInteractorProtocol: AnyObject {
    var movie: Movie { get }
    func getTrailerID(filmName: String, filmYear: String)
}

class MoviePageInteractor: MoviePageInteractorProtocol {
    weak var presenter: MoviePagePresenterProtocol?
    let movie: Movie
    let sharedApi = NetworkManager.access
    
    init(movie: Movie){
        self.movie = movie
        
    }
    
    func getTrailerID(filmName: String, filmYear: String) {
        sharedApi.getYouTubeTrailer(filmName: filmName, filmYear: filmYear) { [weak self] result  in
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
