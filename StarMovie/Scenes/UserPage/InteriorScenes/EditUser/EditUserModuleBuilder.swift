//
//  EditUserModuleBuilder.swift
//  StarMovie
//
//  Created by petar on 27.10.2024
//

import UIKit

class EditUserModuleBuilder {
    static func build(user: User, transitioningDelegate: UIViewControllerTransitioningDelegate, delegate: EditUserModuleDelegate) -> EditUserViewController {
        let interactor = EditUserInteractor()
        let router = EditUserRouter()
        let presenter = EditUserPresenter(interactor: interactor, router: router, user: user)
        let viewController = EditUserViewController()
        viewController.transitioningDelegate = transitioningDelegate
        viewController.modalPresentationStyle = .custom
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        router.delegate = delegate
        return viewController
    }
}
