//
//  SearchPagePresenter.swift
//  Super easy dev
//
//  Created by petar on 17.04.2024
//

protocol SearchPagePresenterProtocol: AnyObject {
}

class SearchPagePresenter {
    weak var view: SearchPageViewProtocol?
    var router: SearchPageRouterProtocol
    var interactor: SearchPageInteractorProtocol

    init(interactor: SearchPageInteractorProtocol, router: SearchPageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPagePresenter: SearchPagePresenterProtocol {
}
