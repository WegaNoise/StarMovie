//
//  NavigationConroller.swift
//  StarMovie
//
//  Created by petar on 14.04.2024.
//

import UIKit
import SnapKit

final class NavigationConroller: UINavigationController {
    
    private let navAppearence = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension NavigationConroller {
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


    
