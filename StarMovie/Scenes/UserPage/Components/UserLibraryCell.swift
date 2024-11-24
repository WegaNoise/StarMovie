//
//  userLibraryCell.swift
//  StarMovie
//
//  Created by petar on 04.11.2024.
//

import UIKit
import SnapKit

final class UserLibraryCell: UICollectionViewCell {
    
    static let identifier: String = "userLibraryCell"
    
    private let menuItemLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 28, blod: false)
        label.textColor = Resources.Colors.mainColorDark
        label.textAlignment = .center
        return label
    }()
    
    private let menuItemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Resources.Colors.mainColorDark
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    override var isHighlighted: Bool{
        didSet{
            self.backgroundColor = self.isHighlighted ? Resources.Colors.accentColor : Resources.Colors.mainColorLight
            menuItemLabel.textColor = self.isHighlighted ? Resources.Colors.mainColorLight : Resources.Colors.mainColorDark
            menuItemImage.tintColor = self.isHighlighted ? Resources.Colors.mainColorLight : Resources.Colors.mainColorDark
        }
    }
    
    func configCell(_ item: MenuItem) {
        menuItemLabel.text = item.title
        menuItemImage.image = UIImage(systemName: item.imageName)
        self.backgroundColor = item.color.uiColor
        self.isUserInteractionEnabled = item.isUsed
    }
}

private extension UserLibraryCell {
    func setupConstraints() {
        self.addSubviews(menuItemLabel, menuItemImage)
        
        menuItemImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(self.bounds.width / 7)
        }
        
        menuItemLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(menuItemImage.snp.trailing)
        }
    }
}
