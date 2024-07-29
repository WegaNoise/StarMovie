//
//  Resources.swift
//  StarMovie
//
//  Created by petar on 12.04.2024.
//

import UIKit

enum Resources{
    
    enum Colors {
        static let mainColorGray = UIColor(hexString: "262626", alpha: 1.0)
        static let mainColorDark = UIColor(hexString: "000000", alpha: 1.0)
        static let mainColorLight = UIColor(hexString: "D0D0D1", alpha: 1.0)
        static let accentColor = UIColor(hexString: "57DC82", alpha: 1.0)
        static let ultraColorLight = UIColor(hexString: "D0D0D1", alpha: 0.5)
    }
    
    enum Titls {
        static let homePage = "Home Page"
        static let searchPage = "Search"
        static let userPage = "Profile"
    }
    
    enum Fonts {
        static func gillSansFont(size: CGFloat, blod: Bool) -> UIFont{
            let font = blod ? "GillSans-Bold" : "GillSans"
            return UIFont(name: font, size: size) ?? UIFont()
        }
    }
    
    enum Url {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let keyApi = "74317d7305e39a33d9cf9a5836789f8a"
        static let accessKeyAPI = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NDMxN2Q3MzA1ZTM5YTMzZDljZjlhNTgzNjc4OWY4YSIsInN1YiI6IjY2M2JhOGM1MDQzOWZkMGQwZjlhYmVlNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-wSBoNgNzcVuB-5eXRX-XM2qgF9XCJmwjl9bXW519sM"
        static let imageUrlPath = "https://image.tmdb.org/t/p/w500/"
    }
}
