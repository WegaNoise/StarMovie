//
//  UserPagePresenter.swift
//  Super easy dev
//
//  Created by petar on 17.04.2024
//

protocol UserPagePresenterProtocol: AnyObject {
}

class UserPagePresenter {
    weak var view: UserPageViewProtocol?
    var router: UserPageRouterProtocol
    var interactor: UserPageInteractorProtocol

    init(interactor: UserPageInteractorProtocol, router: UserPageRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension UserPagePresenter: UserPagePresenterProtocol {
}
