//
//  MenuCollectionView.swift
//  StarMovie
//
//  Created by petar on 04.05.2024.
//

import UIKit
// horizontal manu in search page, change category
final class MenuCollectionView: UICollectionView {
    
    private let collectionFlowLayout = UICollectionViewFlowLayout()
    
    let categoryMenuArray = ["Horror", "Comedy", "Documentary", "Racing", "Biography", "Mult", "Anime", "Action"]
    
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
        collectionFlowLayout.minimumInteritemSpacing = 5
        contentInset.left = 10
        contentInset.right = 10
        bounces = false
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.id)
        dataSource = self
        delegate = self
        selectItem(at: [0,0], animated: true, scrollPosition: [])
    }
}

//MARK: -UICollectionViewDataSource
extension MenuCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.id, for: indexPath) as! MenuCell
        cell.categoryMenuLabel.text = categoryMenuArray[indexPath.row]
        return cell
    }
}

extension MenuCollectionView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

//MARK: -UICollectionViewDelegateFlowLayout
extension MenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryFont = Resources.Fonts.gillSansFont(size: 18, blod: false)
        let categoryAttributes = [NSAttributedString.Key.font: categoryFont]
        let categoryWidth = categoryMenuArray[indexPath.item].size(withAttributes: categoryAttributes).width
        return CGSize(width: categoryWidth + 18, height: collectionView.bounds.height * 0.8)
    }
}
