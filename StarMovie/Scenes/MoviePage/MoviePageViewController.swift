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
    func changeAddInLibraryButton(setConfig: [String])
    func showErrorView(error: NetworkErrors)
}

final class MoviePageViewController: UIViewController {
    
    var presenter: MoviePagePresenterProtocol?

    private let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
    private let movieScrollView = MovieScrollView()
    
    private lazy var errorView = ErrorView()
    
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
    }
    
    func configNavBar(){
        navigationItem.title = Resources.Titls.moviePage
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = Resources.Colors.mainColorLight
    }
    
    @objc 
    func didTapBackButton(){
        presenter?.pressBeckButtton()
    }
}

// MARK: - MoviePageViewProtocol
extension MoviePageViewController: MoviePageViewProtocol {
    func startShowData() {
        view.addSubview(self.movieScrollView)
        movieScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        movieScrollView.movieScrollDelegate = self
        guard let movie = presenter?.movie else { return }
        activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
        movieScrollView.addContentInScrollView(movie: movie)
    }
    
    func changeAddInLibraryButton(setConfig: [String]) {
        movieScrollView.setConfigWatchLaterButton(config: setConfig)
    }
    
    func showErrorView(error: NetworkErrors) {
        activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
        view.addSubview(errorView)
        errorView.configView(error: error)
    }
}

extension MoviePageViewController: MovieScrollViewProtocol {
    func pressedButtonAddMovie() {
        presenter?.pressedButtonAddLibrary()
    }
    
    func starRatingChanged(newValue: Int) {
        presenter?.receivedNewStarsValue(newValue: newValue)
    }
}
