//
//  SearchCollectionView.swift
//  StarMovie
//
//  Created by petar on 31.08.2024.
//

import UIKit

protocol SearchCollectionViewProtocol: AnyObject {
    func selectedItem(index: IndexPath)
}

final class SearchCollectionView: UICollectionView {
    
    weak var searchCollectionViewDelegate: SearchCollectionViewProtocol?
    
    init(){
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: collectionViewLayout)
        configCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchCollectionView {
    func configCollectionView() {
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        delaysContentTouches = false
        contentInset.top = 20
        contentInset.bottom = 150
        register(MainMovieCollectionViewCell.self, forCellWithReuseIdentifier: MainMovieCollectionViewCell.searchId)
        delegate = self
    }
}

extension SearchCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 3) * 0.9, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchCollectionViewDelegate?.selectedItem(index: indexPath)
    }
}
