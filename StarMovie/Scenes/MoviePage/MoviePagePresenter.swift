//
//  MoviePagePresenter.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//

protocol MoviePagePresenterProtocol: AnyObject {
    var movie: Movie? { get }
    func getTrailerID(id: String)
    func pressBeckButtton()
    func viewDidLoad()
    func pressedButtonLibrary()
    func receivedNewStarsValue(newValue: Int)
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
    func viewDidLoad() {
        interactor.getTrailerID()
        movie = interactor.movie
    }
    
    func getTrailerID(id: String) {
        movie?.trailerID = id
        movie?.watchLater = false
        view?.startShowData()
    }
    
    func pressBeckButtton(){
        router.goOutMoviePage()
    }
    
    func pressedButtonLibrary() {
        guard let value = movie?.watchLater else { return }
        movie?.watchLater = !value
        if movie?.watchLater == true {
            view?.movieInLibrary(inLibrary: false)
        }else if movie?.watchLater == false {
            view?.movieInLibrary(inLibrary: true)
        }
    }
    
    func receivedNewStarsValue(newValue: Int){
        print("new stars value - \(newValue)")
    }
}
