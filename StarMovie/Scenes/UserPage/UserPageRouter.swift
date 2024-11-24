//
//  UserPageRouter.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

import UIKit

protocol UserPageRouterProtocol {
    func showEditScreen(_ user: User)
    func showWatchLaterPage()
    func showMovieRatingsPage()
}

class UserPageRouter: UserPageRouterProtocol {
    weak var viewController: UserPageViewController?
    
    func showEditScreen(_ user: User) {
        guard let tabBarController = viewController?.tabBarController,
              let selectedController = tabBarController.selectedViewController as? UINavigationController
        else { return }
        
        if let userPageVC = selectedController.viewControllers.first as? UserPageViewController {
            let editUserVC = EditUserModuleBuilder.build(user: user, transitioningDelegate: userPageVC.customTransitioningDelegate, delegate: userPageVC)
            userPageVC.present(editUserVC, animated: true)
        }
    }
    
    func showWatchLaterPage() {
        guard let viewController = viewController else { return }
        let watchLaterPage = WatchLaterModuleBuilder.build()
        viewController.navigationController?.pushViewController(watchLaterPage, animated: true)
    }
    
    func showMovieRatingsPage() {
        guard let viewController = viewController else { return }
        let movieRatingsPage = MovieRatingsModuleBuilder.build()
        viewController.navigationController?.pushViewController(movieRatingsPage, animated: true)
    }
}
