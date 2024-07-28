//
//  MoviePagePresenter.swift
//  Super easy dev
//
//  Created by petar on 22.06.2024
//

protocol MoviePagePresenterProtocol: AnyObject {
}

class MoviePagePresenter {
    weak var view: MoviePageViewProtocol?
    var router: MoviePageRouterProtocol
    var interactor: MoviePageInteractorProtocol

    init(interactor: MoviePageInteractorProtocol, router: MoviePageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MoviePagePresenter: MoviePagePresenterProtocol {
}
