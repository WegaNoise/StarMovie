//
//  Resources.swift
//  StarMovie
//
//  Created by petar on 12.04.2024.
//

import UIKit

enum Resources{
    
    enum Colors{
        static var mainColorGray = UIColor(hexString: "262626")
        static var mainColorDark = UIColor(hexString: "000000")
        static var mainColorLight = UIColor(hexString: "D0D0D1")
    }
    
    enum Titls{
        static var homePage = "Home Page"
        static var searchPage = "Search"
        static var userPage = "Profile"
    }
    
    enum Fonts{
        static func gillSansFont(size: CGFloat) -> UIFont{
            return UIFont(name: "Gill Sans", size: size) ?? UIFont()
        }
    }
}
