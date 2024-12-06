//
//  CustomTabBarController.swift
//  StarMovie
//
//  Created by petar on 19.04.2024.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar")
        setupTabBarItems()
        selectedIndex = 1
    }
}

private extension CustomTabBarController {
    func setupTabBarItems() {
        let searchPage = generateVC(viewController: SearchPageModuleBuilder.build(),
                                    title: nil,
                                    image: UIImage(systemName: "magnifyingglass.circle"))
        let homePage = generateVC(viewController: HomePageModuleBuilder.build(),
                                  title: nil,
                                  image: UIImage(systemName: "house.fill"))
        let userPage = generateVC(viewController: UserPageModuleBuilder.build(),
                                  title: nil,
                                  image: UIImage(systemName: "person.fill"))
        
        setViewControllers([searchPage, homePage, userPage], animated: true)
    }
}
