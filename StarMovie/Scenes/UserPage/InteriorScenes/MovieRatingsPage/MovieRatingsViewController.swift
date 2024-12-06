//
//  MovieRatingsViewController.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

import UIKit
import SnapKit

protocol MovieRatingsViewProtocol: AnyObject {
    func showRatingCollectionView()
    func ratingMovieNotFound()
    func updatedDataCollectionView()
}

final class MovieRatingsViewController: UIViewController {
    var presenter: MovieRatingsPresenterProtocol?
    
    private lazy var notFoundMovieView = NotFoundView()
    
    private let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
    private let ratingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset.top = 20
        collectionView.delaysContentTouches = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Resources.Colors.accentColor
        refreshControl.addTarget(self, action: #selector(movieListUpdate), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoad()
    }
}


private extension MovieRatingsViewController {
    func initialize() {
        activityIndicator.changeStateActivityIndicator(state: .showAndAnimate)
        view.addSubview(activityIndicator)
        view.backgroundColor = Resources.Colors.mainColorGray
        configNavBar()
    }
    
    func configNavBar(){
        navigationItem.title = Resources.Titls.movieRatingsPage
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(pressBackButton))
    }
    
    @objc
    func pressBackButton(){
        presenter?.pressBeckButtton()
    }
    
    func layoutRatingCollectionView(){
        activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
        view.addSubview(ratingCollectionView)
        ratingCollectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.top.bottom.equalToSuperview()
        }
    }
    
    @objc
    func movieListUpdate() {
        presenter?.movieListUpdate()
    }
}

// MARK: - MovieRatingsViewProtocol
extension MovieRatingsViewController: MovieRatingsViewProtocol {
    func showRatingCollectionView() {
        layoutRatingCollectionView()
        ratingCollectionView.delegate = self
        ratingCollectionView.dataSource = self
        ratingCollectionView.refreshControl = refreshControl
        ratingCollectionView.register(MovieRatingCollectionViewCell.self, forCellWithReuseIdentifier: MovieRatingCollectionViewCell.id)
    }
    
    func ratingMovieNotFound() {
        notFoundMovieView.configurateDescriptionForView(description: Resources.DescriptionNotFoundView.userRating.text)
        view.addSubview(notFoundMovieView)
    }
    
    func updatedDataCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.ratingCollectionView.reloadData()
            if self.refreshControl.isRefreshing {
                self.ratingCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension MovieRatingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movieRatingList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieRatingCollectionViewCell.id,
                                                      for: indexPath) as! MovieRatingCollectionViewCell
        cell.configurateCell(with: presenter?.movieByIndexPath(indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectMovie(indexPath)
    }
}
