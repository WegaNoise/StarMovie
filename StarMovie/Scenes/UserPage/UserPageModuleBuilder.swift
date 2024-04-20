//
//  UserPageModuleBuilder.swift
//  Super easy dev
//
//  Created by petar on 17.04.2024
//

import UIKit

class UserPageModuleBuilder {
    static func build() -> UserPageViewController {
        let interactor = UserPageInteractor()
        let router = UserPageRouter()
        let presenter = UserPagePresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "UserPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserPage") as! UserPageViewController
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
