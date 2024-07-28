//
//  MoviePageInteractor.swift
//  Super easy dev
//
//  Created by petar on 22.06.2024
//

protocol MoviePageInteractorProtocol: AnyObject {
}

class MoviePageInteractor: MoviePageInteractorProtocol {
    weak var presenter: MoviePagePresenterProtocol?
}
