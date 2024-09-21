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
    func hideCollectionVeiw(isHide: Bool)
}

final class SearchPageViewController: UIViewController {
    
    var presenter: SearchPagePresenterProtocol?
    
    private let searchTextField = SearchTextField()
            
    private let filmCollectionView = SearchCollectionView()
    
    private let horizontalMenuCollectionView = MenuCollectionView()
    
    private let activityIndicator = StarMovieActivityIndicator(sizeView: .medium)
    
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
    
    func addCompontntsForScreen(){
        view.addSubviews(searchTextField, horizontalMenuCollectionView, activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
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
    
    func hideCollectionVeiw(isHide: Bool) {
        activityIndicator.changeStateActivityIndicator(state: isHide ? .showAndAnimate : .hideAndStop)
        filmCollectionView.isHidden = isHide
    }
    
    func newMovieListReceived() {
        hideCollectionVeiw(isHide: false)
        filmCollectionView.reloadData()
    }
    
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
}

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

extension SearchPageViewController: HorizontalMenuProtocol {
    func selectedCategory(genresID: Int) {
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
        cell.configDataForCollectionViewCell(movie: movie)
        return cell
    }
}

extension SearchPageViewController: SearchCollectionViewProtocol{
    func selectedItem(index: IndexPath) {
        presenter?.selectedMovie(index: index)
    }
}

