//
//  HomeCollectionView.swift
//  StarMovie
//
//  Created by petar on 11.04.2024.
//

import UIKit

protocol SelectedItemCollectionViewProtocol: AnyObject{
    func selectItem(index: IndexPath)
}

final class HomeCollectionView: UICollectionView {

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

private extension HomeCollectionView{
    func configCollectionView(){
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        backgroundColor = Resources.Colors.mainColorGray
        contentInset.top = 20
        contentInset.bottom = 150
        register(HomeMovieCell.self, forCellWithReuseIdentifier: HomeMovieCell.id)
        delegate = self
    }
}

extension HomeCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 3) * 0.9, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItemDelegate?.selectItem(index: indexPath)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.deselectItem(at: indexPath, animated: false)
        }
    }
}
