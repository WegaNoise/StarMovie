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
    func menuItemsUserPage() -> Int
    func cellDataForIndexPath(indexPath: IndexPath) -> MenuItem
    func userSelectedMenuItem(indexPath: IndexPath)
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
    
    func menuItemsUserPage() -> Int {
        return Resources.UserPageLibrary.menuItems.count
    }
    
    func cellDataForIndexPath(indexPath: IndexPath) -> MenuItem {
        return Resources.UserPageLibrary.menuItems[indexPath.row]
    }
    
    func userSelectedMenuItem(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            router.pushWatchLaterPage()
        case 1:
            router.pushMovieRatingsPage()
        default:
            break
        }
    }
    
    func userPressedEditProfile(userName: String, userAvatar: Data) {
        let userProfile = User(userName: userName, userAvatar: userAvatar)
        router.showEditScreen(userProfile)
    }
    
    func loadUserData() {
        interactor.loadUserData()
    }
}
