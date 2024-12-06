//
//  HomePageViewController.swift
//  StarMovie
//
//  Created by petar on 11.04.2024
//

import UIKit
import SnapKit

protocol HomePageViewProtocol: AnyObject {
    func initializeCollectionView()
    func showErrorView(error: NetworkErrors)
}

final class HomePageViewController: UIViewController {
    
    var presenter: HomePagePresenterProtocol?
    
    private let moviesCollectionView = HomeMovieCollectionView()
    
    private let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
    private lazy var errorAlertView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoad()
    }
}

// MARK: - Private functions
private extension HomePageViewController {
    func initialize() {
        view.backgroundColor = Resources.Colors.mainColorGray
        navigationItem.title = Resources.Titls.homePage
        configureActivityIndicator()
    }
    
    func configureActivityIndicator() {
        activityIndicator.changeStateActivityIndicator(state: .showAndAnimate)
        view.addSubview(activityIndicator)
    }
}

// MARK: - HomePageViewProtocol
extension HomePageViewController: HomePageViewProtocol {
    func initializeCollectionView() {
        activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
        view.addSubview(moviesCollectionView)
        moviesCollectionView.dataSource = self
        moviesCollectionView.moviesSelectionDelegate = self
        moviesCollectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.bottom.top.equalToSuperview()
        }
    }
    
    func showErrorView(error: NetworkErrors) {
        activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
        view.addSubview(self.errorAlertView)
        errorAlertView.configView(error: error)
        errorAlertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: MainMovieCollectionViewCell.homeId, for: indexPath) as! MainMovieCollectionViewCell
        guard let movie = presenter?.returnMovieForIndex(index: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.configDataForCollectionViewCell(movie: movie)
        return cell
    }
}

extension HomePageViewController: SelectedItemCollectionViewProtocol {
    func moviesSelection(index: IndexPath) {
        presenter?.selectMovie(index: index)
    }
}
