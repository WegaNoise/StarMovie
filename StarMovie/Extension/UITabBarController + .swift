//
//  UITabBarController + .swift
//  StarMovie
//
//  Created by petar on 19.04.2024.
//

import UIKit

extension UITabBarController {
    func generateVC(viewController: UIViewController, title: String?, image: UIImage?) -> UIViewController {
        let viewController = viewController
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let navController = NavigationController(rootViewController: viewController)

        return navController
    }
}
