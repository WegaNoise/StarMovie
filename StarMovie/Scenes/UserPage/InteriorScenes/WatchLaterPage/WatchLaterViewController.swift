//
//  WatchLaterViewController.swift
//  StarMovie
//
//  Created by petar on 05.11.2024
//

import UIKit
import SnapKit

protocol WatchLaterViewProtocol: AnyObject {
    func showWatchLaterCollectionView()
    func showNotFoundView()
    func updatedDataCollectionView()
}

final class WatchLaterViewController: UIViewController {
    
    var presenter: WatchLaterPresenterProtocol?
    
    private lazy var notFoundMovieView = NotFoundView()
    
    private let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
    private let watchLaterCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.backgroundColor = .clear
        collection.contentInset.top = 20
        collection.delaysContentTouches = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection
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

private extension WatchLaterViewController {
    func initialize() {
        activityIndicator.changeStateActivityIndicator(state: .showAndAnimate)
        view.addSubview(activityIndicator)
        view.backgroundColor = Resources.Colors.mainColorGray
        configNavBar()
    }
    
    func configNavBar() {
        navigationItem.title = Resources.Titls.watchLaterPage
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(pressBackButton))
    }
    
    @objc
    func pressBackButton() {
        presenter?.pressBeckButtton()
    }
    
    func watchLaterCollectionViewLayout() {
        activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
        view.addSubview(watchLaterCollectionView)
        watchLaterCollectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.top.bottom.equalToSuperview()
        }
    }
    
    @objc
    func movieListUpdate() {
        presenter?.movieListUpdate()
    }
}

// MARK: - WatchLaterViewProtocol
extension WatchLaterViewController: WatchLaterViewProtocol {
    func showWatchLaterCollectionView() {
        watchLaterCollectionViewLayout()
        watchLaterCollectionView.delegate = self
        watchLaterCollectionView.dataSource = self
        watchLaterCollectionView.refreshControl = refreshControl
        watchLaterCollectionView.register(WatchLaterCollectionViewCell.self, forCellWithReuseIdentifier: WatchLaterCollectionViewCell.id)
    }
    
    func showNotFoundView() {
        notFoundMovieView.configurateDescriptionForView(description: Resources.DescriptionNotFoundView.watchLater.text)
        view.addSubview(notFoundMovieView)
    }
    
    func updatedDataCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.watchLaterCollectionView.reloadData()
            if self.refreshControl.isRefreshing {
                self.watchLaterCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension WatchLaterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movieList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchLaterCollectionViewCell.id, for: indexPath) as! WatchLaterCollectionViewCell
        let movie = presenter?.movieList[indexPath.row] ?? MovieEntity()
        cell.delegate = self
        cell.configurateCell(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectedMovie(indexPath.row)
    }
}

extension WatchLaterViewController: WatchLaterCollectionViewCellDelegate {
    func didTapIsWatched(cell: WatchLaterCollectionViewCell) {
        guard let indexCell = watchLaterCollectionView.indexPath(for: cell) else { return }
        presenter?.pressedIsWatchedCheckbox(indexCell.row)
    }
}
