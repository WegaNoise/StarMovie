//
//  MoviePagePresenter.swift
//  Super easy dev
//
//  Created by petar on 22.06.2024
//

protocol MoviePagePresenterProtocol: AnyObject {
    var movie: Movie? { get }
    func getMovieName()
    func pressBeckButtton()
}

class MoviePagePresenter {
    weak var view: MoviePageViewProtocol?
    var router: MoviePageRouterProtocol
    var interactor: MoviePageInteractorProtocol
    var movie: Movie?

    init(interactor: MoviePageInteractorProtocol, router: MoviePageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MoviePagePresenter: MoviePagePresenterProtocol {
    func getMovieName() {
        movie = interactor.movie
    }
    
    
    
    
    
    func pressBeckButtton(){
        router.goOutMoviePage()
    }
    
}
