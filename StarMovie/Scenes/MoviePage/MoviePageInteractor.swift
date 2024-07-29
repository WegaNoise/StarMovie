//
//  MoviePageInteractor.swift
//  Super easy dev
//
//  Created by petar on 22.06.2024
//

protocol MoviePageInteractorProtocol: AnyObject {
    var movie: Movie { get }
}

class MoviePageInteractor: MoviePageInteractorProtocol {
    weak var presenter: MoviePagePresenterProtocol?
    let movie: Movie
    
    init(movie: Movie){
        self.movie = movie
    }
}
