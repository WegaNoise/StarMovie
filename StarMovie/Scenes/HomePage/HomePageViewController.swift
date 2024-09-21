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
}

final class HomePageViewController: UIViewController {
    
    var presenter: HomePagePresenterProtocol?
    
    private let homeCollectionView = HomeMovieCollectionView()
    
    private let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewToReady()
    }
}

// MARK: - Private functions
private extension HomePageViewController {
    func initialize() {
        view.backgroundColor = Resources.Colors.mainColorGray
        navigationItem.title = Resources.Titls.homePage
        activityIndicator.changeStateActivityIndicator(state: .showAndAnimate)
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - HomePageViewProtocol
extension HomePageViewController: HomePageViewProtocol {
    func initializeCollectionView() {
        activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
        
        view.addSubview(homeCollectionView)
        homeCollectionView.dataSource = self
        homeCollectionView.selectItemDelegate = self
        homeCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.top.equalToSuperview()
        }
    }
}

extension HomePageViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: MainMovieCollectionViewCell.homeId, for: indexPath) as! MainMovieCollectionViewCell
        guard let movie = presenter?.returnDataByMovie(index: indexPath.row) else { return UICollectionViewCell() }
        cell.configDataForCollectionViewCell(movie: movie)
        return cell
    }
}

extension HomePageViewController: SelectedItemCollectionViewProtocol{
    func selectedItem(index: IndexPath) {
        presenter?.selectMovie(index: index)
    }
}
