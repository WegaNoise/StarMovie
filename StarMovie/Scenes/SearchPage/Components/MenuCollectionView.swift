//
//  MenuCollectionViewCell.swift
//  StarMovie
//
//  Created by petar on 04.05.2024.
//

import UIKit
// horizontal manu in search page, change category
final class MenuCollectionView: UICollectionView {
    
    private let collectionFlowLayout = UICollectionViewFlowLayout()
    let id = "Menu"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionFlowLayout)
        configMenuCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: -Private method collectionView
private extension MenuCollectionView{
    func configMenuCollection(){
        collectionFlowLayout.scrollDirection = .horizontal
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: id)
        dataSource = self
        delegate = self
        
    }
}

//MARK: -UICollectionViewDataSource
extension MenuCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        switch indexPath.row{
        case 0: cell.backgroundColor = Resources.Colors.accentColor
        default:
            cell.backgroundColor = Resources.Colors.mainColorDark
        }
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension MenuCollectionView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//MARK: -UICollectionViewDelegateFlowLayout
extension MenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.bounds.height * 0.8)
    }
}
