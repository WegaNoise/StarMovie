//
//  MenuCell.swift
//  StarMovie
//
//  Created by petar on 06.05.2024.
//

import UIKit
import SnapKit

final class MenuCell: UICollectionViewCell {
    
    static let id = "Menu Cell"
    
    private let categoryMenuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 18, blod: false)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool{
        didSet{
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = self.isSelected ? Resources.Colors.accentColor : Resources.Colors.mainColorDark
                self.categoryMenuLabel.textColor = self.isSelected ? Resources.Colors.mainColorGray : Resources.Colors.mainColorLight
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func configTitleCell(_ title: String) {
        categoryMenuLabel.text = title
    }
}

private extension MenuCell {
    func setupCell(){
        backgroundColor = Resources.Colors.mainColorDark
        contentView.addSubview(categoryMenuLabel)
        categoryMenuLabel.snp.makeConstraints { label in
            label.centerX.centerY.equalToSuperview()
        }
    }
}
