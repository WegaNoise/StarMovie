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
    
    let homeCollectionView = HomeCollectionView()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
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
        activityIndicator.color = Resources.Colors.accentColor
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { indicator in
            indicator.centerX.centerY.equalToSuperview()
            indicator.height.width.equalTo(150)
        }
    }
}

// MARK: - HomePageViewProtocol
extension HomePageViewController: HomePageViewProtocol {
    func initializeCollectionView() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        view.addSubview(homeCollectionView)
        homeCollectionView.dataSource = self
        homeCollectionView.selectItemDelegate = self
        homeCollectionView.snp.makeConstraints { collection in
            collection.leading.equalToSuperview().offset(10)
            collection.trailing.equalToSuperview().offset(-10)
            collection.bottom.top.equalToSuperview()
        }
    }
}

extension HomePageViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCell.id, for: indexPath) as! HomeMovieCell
        guard let movie = presenter?.returnDataByMovie(index: indexPath.row) else { return UICollectionViewCell() }
        cell.getDataForCollectionViewCell(imagePath: movie.posterPath ?? " ",
                                          filmName: movie.title ?? "Movie name",
                                          dateRelis: movie.releaseDate ?? " Release date")
        return cell
    }
}

extension HomePageViewController: SelectedItemCollectionViewProtocol{
    func selectItem(index: IndexPath) {
        presenter?.selectMovie(index: index.row)
    }
}
