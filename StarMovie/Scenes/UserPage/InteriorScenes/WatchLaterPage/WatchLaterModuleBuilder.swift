//
//  WatchLaterModuleBuilder.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

import UIKit

class WatchLaterModuleBuilder {
    static func build() -> WatchLaterViewController {
        let interactor = WatchLaterInteractor()
        let router = WatchLaterRouter()
        let presenter = WatchLaterPresenter(interactor: interactor, router: router)
        let viewController = WatchLaterViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
