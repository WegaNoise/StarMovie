//
//  HomeCollectionView.swift
//  StarMovie
//
//  Created by petar on 11.04.2024.
//

import UIKit

protocol SelectedItemCollectionViewProtocol: AnyObject{
    func selectedItem(index: IndexPath)
}

final class HomeMovieCollectionView: UICollectionView {

    weak var selectItemDelegate: SelectedItemCollectionViewProtocol?
    
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

private extension HomeMovieCollectionView{
    func configCollectionView(){
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        backgroundColor = Resources.Colors.mainColorGray
        contentInset.top = 20
        contentInset.bottom = 150
        delaysContentTouches = false
        register(MainMovieCollectionViewCell.self, forCellWithReuseIdentifier: MainMovieCollectionViewCell.homeId)
        delegate = self
    }
}

extension HomeMovieCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 3) * 0.9, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItemDelegate?.selectedItem(index: indexPath)
    }
}
