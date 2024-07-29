//
//  MoviePageViewController.swift
//  Super easy dev
//
//  Created by petar on 22.06.2024
//

import UIKit
import SnapKit
import Kingfisher

protocol MoviePageViewProtocol: AnyObject {
}

final class MoviePageViewController: UIViewController {
    
    var presenter: MoviePagePresenterProtocol?

    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let movieScrollView = MovieScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMovieName()
        initialize()
    }
}


private extension MoviePageViewController {
    func initialize() {
        configNavBar()
        view.backgroundColor = Resources.Colors.mainColorGray
        view.addSubview(movieScrollView)
        movieScrollView.snp.makeConstraints { scrollView in
            scrollView.edges.equalToSuperview()
        }
        guard let movie = presenter?.movie else { return }
        movieScrollView.addContentInScrollView(textName: movie.title ?? " - ",
                                               imagePath: movie.posterPath ?? " - ",
                                               textOverview: movie.overview ?? " - ",
                                               dateRelease: movie.releaseDate ?? " - ", 
                                               ratingValue: movie.voteAverage ?? 0)
    }
    
    func configNavBar(){
        navigationItem.title = "Movie"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(pressBackButton))
    }
    
    @objc func pressBackButton(){
        presenter?.pressBeckButtton()
    }
}

// MARK: - MoviePageViewProtocol
extension MoviePageViewController: MoviePageViewProtocol {
}
