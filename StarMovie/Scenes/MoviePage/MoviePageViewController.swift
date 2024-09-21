//
//  MoviePageViewController.swift
//  StarMovie
//
//  Created by petar on 22.06.2024
//

import UIKit
import SnapKit

protocol MoviePageViewProtocol: AnyObject {
    func startShowData()
    func movieInLibrary(inLibrary: Bool)
}

final class MoviePageViewController: UIViewController {
    
    var presenter: MoviePagePresenterProtocol?

    private let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
    private let movieScrollView = MovieScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoad()
    }
}

private extension MoviePageViewController {
    func initialize() {
        configNavBar()
        view.backgroundColor = Resources.Colors.mainColorGray
        activityIndicator.changeStateActivityIndicator(state: .showAndAnimate)
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configNavBar(){
        navigationItem.title = "Movie"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(pressBackButton))
    }
    
    @objc 
    func pressBackButton(){
        presenter?.pressBeckButtton()
    }
}

// MARK: - MoviePageViewProtocol
extension MoviePageViewController: MoviePageViewProtocol {
    func startShowData() {
        DispatchQueue.main.async {
            self.view.addSubview(self.movieScrollView)
            self.movieScrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            self.movieScrollView.movieScrollDelegate = self
            guard let movie = self.presenter?.movie else { return }
            self.activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
            self.movieScrollView.addContentInScrollView(movie: movie)
        }
    }
    
    func movieInLibrary(inLibrary: Bool){
        movieScrollView.configWatchLaterButton(inLibrary: inLibrary)
    }
}

extension MoviePageViewController: MovieScrollViewProtocol {
    func pressedButtonAddMovie() {
        presenter?.pressedButtonLibrary()
    }
    
    func starRatingChanged(newValue: Int) {
        presenter?.receivedNewStarsValue(newValue: newValue)
    }
}
