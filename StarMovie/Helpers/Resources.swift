//
//  Resources.swift
//  StarMovie
//
//  Created by petar on 12.04.2024.
//

import UIKit

enum Resources{
    
    enum Colors {
        case mainGray
        case mainDark
        case mainLight
        case accent
        case ultraLight
        
        static let mainColorGray = UIColor(hexString: "262626", alpha: 1.0)
        static let mainColorDark = UIColor(hexString: "000000", alpha: 1.0)
        static let mainColorLight = UIColor(hexString: "D0D0D1", alpha: 1.0)
        static let accentColor = UIColor(hexString: "57DC82", alpha: 1.0)
        static let ultraColorLight = UIColor(hexString: "D0D0D1", alpha: 0.5)
        
        var uiColor: UIColor {
            switch self {
            case .mainGray:
                return Resources.Colors.mainColorGray
            case .mainDark:
                return Resources.Colors.mainColorDark
            case .mainLight:
                return Resources.Colors.mainColorLight
            case .accent:
                return Resources.Colors.accentColor
            case .ultraLight:
                return Resources.Colors.ultraColorLight
            }
        }
    }
    
    enum Genres {
        static let genreArray = [
            Genre(name: "Drama", id: 18),
            Genre(name: "Fantasy", id: 14),
            Genre(name: "Horror", id: 27),
            Genre(name: "Western", id: 37),
            Genre(name: "Romance", id: 10752),
            Genre(name: "Animation", id: 16),
            Genre(name: "Documentary", id: 99),
            Genre(name: "Comedy", id: 35)
        ]
        
        static func getGenreId(indexPath: IndexPath) -> Int {
            return Resources.Genres.genreArray[indexPath.row].id
        }
        
        static func getGenreNameArray() -> [String] {
            var genreNameArray: [String] = []
            for genre in Resources.Genres.genreArray {
                genreNameArray.append(genre.name)
            }
            return genreNameArray
        }
    }
    
    enum Titls {
        static let homePage = "Home Page"
        static let searchPage = "Search"
        static let userPage = "Profile"
        static let moviePage = "Movie"
        static let watchLaterPage = "Watch Later"
        static let movieRatingsPage = "Your Movie Ratings"
    }
    
    enum Fonts {
        static func gillSansFont(size: CGFloat, blod: Bool) -> UIFont{
            let font = blod ? "GillSans-Bold" : "GillSans"
            return UIFont(name: font, size: size) ?? UIFont()
        }
    }
    
    enum UrlMovieDB {
        static let baseURL = "https://api.themoviedb.org/3/"
// Enter your apiKey data received https://developer.themoviedb.org/docs/getting-started
        static let keyApi = SensitiveData.movieDBApiKey
        static let accessKeyAPI = SensitiveData.movieDBApiUrl
        static let imageUrlPath = "https://image.tmdb.org/t/p/w500/"
        static let searchUrlPath = "https://api.themoviedb.org/3/search/movie"
        static let searchMovieListPath = "https://api.themoviedb.org/3/discover/movie"
        static let movieByIdUrlPath = "https://api.themoviedb.org/3/movie/"
    }
    
    enum UrlYouTube {
        static let baseSearhcURL = "https://youtube.googleapis.com/youtube/v3/search"
// Enter your apiKey data received https://developers.google.com/youtube/v3
        static let keyAPI = SensitiveData.youtubeApiKey
    }
    
    enum User {
        static let userAvatarFileName = "userAvatar.png"
        static let userNameDefaultKey = "userNameKey"
    }
    
    enum UserPageLibrary {
        static let menuItems = [MenuItem(title: "Watch Later", imageName: "clock.arrow.circlepath", color: .mainLight, isUsed: true),
                                MenuItem(title: "My Movie Ratings", imageName: "list.number", color: .mainLight, isUsed: true),
                                MenuItem(title: "Import My Data", imageName: "square.and.arrow.down", color: .ultraLight, isUsed: false)]
    }
    
    enum DescriptionNotFoundView {
        case userRating
        case watchLater
        
        var text: String {
            switch self {
            case .userRating:
                return "Rate films and your ratings will be stored on this page"
            case .watchLater:
                return "Movies you want to watch later will be displayed here"
            }
        }
    }
    
    enum WatchLaterButton {
        case inLibrary
        case notInLibrary
        
        var config: [String] {
            switch self {
            case .notInLibrary:
                return ["Watch Later", "pencil.and.list.clipboard"]
            case .inLibrary:
                return ["In Library", "bookmark"]
            }
        }
    }
}
