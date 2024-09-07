//
//  SearchPageViewController.swift
//  StarMovie
//
//  Created by petar on 17.04.2024
//

import UIKit
import SnapKit

protocol SearchPageViewProtocol: AnyObject {
    func initializeCollectionView()
    func newMovieListReceived()
}

final class SearchPageViewController: UIViewController {
    
    var presenter: SearchPagePresenterProtocol?
    
    private let searchTextField = SearchTextField()
    
    private let filmCollectionView = SearchCollectionView()
    
    private let horizontalMenuCollectionView = MenuCollectionView()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoad()
    }
}

private extension SearchPageViewController {
    func initialize() {
        view.backgroundColor = Resources.Colors.mainColorGray
        navigationItem.title = Resources.Titls.searchPage
        searchTextField.searchTextFieldDelegate = self
        horizontalMenuCollectionView.horzontalMenuDelegate = self
        activityIndicator.color = Resources.Colors.accentColor
        activityIndicator.changeState(.showAndStart)
        addCompontntsForScreen()
    }
    
    func addCompontntsForScreen(){
        view.addSubviews(searchTextField, horizontalMenuCollectionView, activityIndicator)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(45)
            make.width.equalTo(view.bounds.width - 20)
        }
        
        horizontalMenuCollectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).inset(-10)
            make.height.equalTo(40)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(150)
        }
    }
}

// MARK: - SearchPageViewProtocol
extension SearchPageViewController: SearchPageViewProtocol {
    func initializeCollectionView(){
        activityIndicator.changeState(.stopAndHidden)
        
        view.addSubview(filmCollectionView)
        filmCollectionView.dataSource = self
        filmCollectionView.searchCollectionViewDelegate = self
        filmCollectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(horizontalMenuCollectionView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    func newMovieListReceived() {
        activityIndicator.changeState(.stopAndHidden)
        filmCollectionView.isHidden = false
        filmCollectionView.reloadData()
    }
}

extension SearchPageViewController: SearchTextFieldProtocol {
    func hideHorizontalMenu() {
        UIView.animate(withDuration: 0.25, delay: 0) {
            self.horizontalMenuCollectionView.transform = CGAffineTransform(scaleX: 1, y: 0.01)
        } completion: { (_) in
            UIView.animate(withDuration: 0.25) {
                self.filmCollectionView.transform = CGAffineTransform(translationX: 0, y: -50)
            }
        }
    }
    
    func showHorizontalMenu() {
        UIView.animate(withDuration: 0.25, delay: 0) {
            self.filmCollectionView.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { (_) in
            UIView.animate(withDuration: 0.25) {
                self.horizontalMenuCollectionView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    func userStartedSearching(query: String) {
        filmCollectionView.isHidden = true
        activityIndicator.changeState(.showAndStart)
        presenter?.gettingUserSearchRequest(request: query)
    }
    
    func searchIsEmpty() {
        presenter?.closeSearch()
    }
}

extension SearchPageViewController: HorizontalMenuProtocol {
    func selectedCategory(genresID: Int) {
        filmCollectionView.isHidden = true
        activityIndicator.changeState(.showAndStart)
        presenter?.changeSelectedGenres(id: genresID)
    }
}

extension SearchPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: MainMovieCollectionViewCell.searchId, for: indexPath) as! MainMovieCollectionViewCell
        guard let movie = presenter?.returnDataByMovie(index: indexPath.row) else { return UICollectionViewCell() }
        cell.getDataForCollectionViewCell(imagePath: movie.posterPath ?? " ",
                                          filmName: movie.title ?? "Movie name",
                                          dateRelis: movie.releaseDate ?? " Release date")
        return cell
    }
}

extension SearchPageViewController: SearchCollectionViewProtocol{
    func selectedItem(index: IndexPath) {
        print(index.row)
    }
}

