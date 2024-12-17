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
    func hideHorizontalMenu()
    func showHorizontalMenu()
    func hideCollectionView(isHide: Bool)
    func showOrHideErrorView(show: Bool, error: NetworkErrors)
}

final class SearchPageViewController: UIViewController {
    
    var presenter: SearchPagePresenterProtocol?
    
    private let searchTextField = SearchTextField()
            
    private let filmCollectionView = SearchCollectionView()
    
    private let horizontalMenuCollectionView = MenuCollectionView()
    
    private let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
    private lazy var errorViewAlert = ErrorView()
    
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
        activityIndicator.changeStateActivityIndicator(state: .showAndAnimate)
        addCompontntsForScreen()
    }
    
    func addCompontntsForScreen() {
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
    }
    
    func animationHorizontalMenu(show: Bool) {
        UIView.animate(withDuration: 0.25, delay: 0) { [weak self] in
            self?.horizontalMenuCollectionView.transform = CGAffineTransform(scaleX: 1, y: show ? 1 : 0.01)
        } completion: { _ in
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.filmCollectionView.transform = CGAffineTransform(translationX: 0, y: show ? 0 : -50)
            }
        }
    }
}

// MARK: - SearchPageViewProtocol
extension SearchPageViewController: SearchPageViewProtocol {
    func initializeCollectionView(){
        activityIndicator.changeStateActivityIndicator(state: .hideAndStop)
        view.addSubview(filmCollectionView)
        filmCollectionView.dataSource = self
        filmCollectionView.searchCollectionViewDelegate = self
        filmCollectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(horizontalMenuCollectionView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    func hideCollectionView(isHide: Bool) {
        filmCollectionView.isHidden = isHide
        activityIndicator.changeStateActivityIndicator(state: isHide ? .showAndAnimate : .hideAndStop)
    }
    
    func newMovieListReceived() {
        filmCollectionView.reloadData()
    }
    
    func hideHorizontalMenu() {
        animationHorizontalMenu(show: false)
    }
    
    func showHorizontalMenu() {
        animationHorizontalMenu(show: true)
    }
    
    func showOrHideErrorView(show: Bool, error: NetworkErrors) {
        if show {
            errorViewAlert.configView(error: error)
            view.addSubview(errorViewAlert)
        } else {
            errorViewAlert.removeFromSuperview()
        }
    }
}

// MARK: - Methods Protocol searchTextField
extension SearchPageViewController: SearchTextFieldProtocol {
    func didBeginEditing() {
        presenter?.textFielddidBeginEditing()
    }
    
    func shouldPressedReturn(text: String) {
        presenter?.textFieldShouldReturn(text: text)
    }
    
    func userEnteredSearchQuery(query: String) {
        presenter?.searchUserMovieData(request: query)
    }
    
    func shouldPressedClear() {
        presenter?.textFieldShouldClear()
    }
}

// MARK: - Methods Protocol horizontalMenuCollectionView
extension SearchPageViewController: HorizontalMenuProtocol {
    func selectedCategory(genresID: Int) {
        presenter?.changeSelectedGenres(id: genresID)
    }
}

// MARK: - Methods CollectionView
extension SearchPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filmCollectionView.dequeueReusableCell(withReuseIdentifier: MainMovieCollectionViewCell.searchId, for: indexPath) as! MainMovieCollectionViewCell
        guard let movie = presenter?.returnDataByMovie(index: indexPath.row) else { return UICollectionViewCell() }
        cell.configDataForCollectionViewCell(movie: movie)
        return cell
    }
}

extension SearchPageViewController: SearchCollectionViewProtocol {
    func selectedItem(index: IndexPath) {
        presenter?.selectedMovie(index: index)
    }
}

