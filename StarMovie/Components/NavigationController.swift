//
//  NavigationConroller.swift
//  StarMovie
//
//  Created by petar on 14.04.2024.
//

import UIKit

final class NavigationController: UINavigationController {
    
    private let navAppearence = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }
}

private extension NavigationController {
    func initialize() {
        navAppearence.titleTextAttributes = [
            .foregroundColor: Resources.Colors.mainColorLight,
            .font: Resources.Fonts.gillSansFont(size: 20, blod: true)
        ]
        navAppearence.configureWithOpaqueBackground()
        navAppearence.backgroundColor = Resources.Colors.mainColorDark
        self.navigationBar.standardAppearance = navAppearence
        self.navigationBar.scrollEdgeAppearance = navAppearence
    }
}

extension NavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = viewControllers.count > 1
    }
}

    
