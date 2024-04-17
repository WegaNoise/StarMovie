//
//  HomeCollectionView.swift
//  StarMovie
//
//  Created by petar on 11.04.2024.
//

import UIKit

final class HomeCollectionView: UICollectionView {

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
        register(HomeMovieCell.self, forCellWithReuseIdentifier: HomeMovieCell.id)
        dataSource = self
        delegate = self
    }
}

extension HomeCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 51
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: HomeMovieCell.id, for: indexPath) as! HomeMovieCell
        cell.configDataInCell(image: UIImage(named: "testPoster"), name: "film \(indexPath.row)", year: 2000 + indexPath.row)
        cell.backgroundColor = Resources.Colors.mainColorLight
        return cell
    }
}

extension HomeCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 3) * 0.9, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
