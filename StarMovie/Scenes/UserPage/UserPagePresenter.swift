//
//  UserPagePresenter.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//
import Foundation

protocol UserPagePresenterProtocol: AnyObject {
    func viewDidLoad()
    func userDataLoaded(user: User)
    func userPressedEditProfile(userName: String, userAvatar: Data)
    func loadUserData()
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
    func viewDidLoad() {
        loadUserData()
    }
    
    func userDataLoaded(user: User) {
        view?.enterUserData(user)
    }
    
    func userPressedEditProfile(userName: String, userAvatar: Data) {
        let userProfile = User(userName: userName, userAvatar: userAvatar)
        router.showEditScreen(userProfile)
    }
    
    func loadUserData() {
        interactor.loadUserData()
    }
}
