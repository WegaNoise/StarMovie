//
//  HomePagePresenter.swift
//  Super easy dev
//
//  Created by petar on 11.04.2024
//

protocol HomePagePresenterProtocol: AnyObject {
}

class HomePagePresenter {
    weak var view: HomePageViewProtocol?
    var router: HomePageRouterProtocol
    var interactor: HomePageInteractorProtocol

    init(interactor: HomePageInteractorProtocol, router: HomePageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomePagePresenter: HomePagePresenterProtocol {
}
