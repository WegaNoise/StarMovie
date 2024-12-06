//
//  HomeCollectionView.swift
//  StarMovie
//
//  Created by petar on 11.04.2024.
//

import UIKit

protocol SelectedItemCollectionViewProtocol: AnyObject {
    func moviesSelection(index: IndexPath)
}

final class HomeMovieCollectionView: UICollectionView {
    
    private enum Constants {
        static let itemHeight: CGFloat = 220
        static let lineSpacing: CGFloat = 10
        static let topInset: CGFloat = 20
        static let bottomInset: CGFloat = 150
    }

    weak var moviesSelectionDelegate: SelectedItemCollectionViewProtocol?
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: collectionViewLayout)
        configCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeMovieCollectionView {
    func configCollectionView(){
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        contentInset.top = Constants.topInset
        contentInset.bottom = Constants.bottomInset
        delaysContentTouches = false
        register(MainMovieCollectionViewCell.self, forCellWithReuseIdentifier: MainMovieCollectionViewCell.homeId)
        delegate = self
    }
}

extension HomeMovieCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width / 3) * 0.9
        return CGSize(width: itemWidth, height: Constants.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moviesSelectionDelegate?.moviesSelection(index: indexPath)
    }
}
