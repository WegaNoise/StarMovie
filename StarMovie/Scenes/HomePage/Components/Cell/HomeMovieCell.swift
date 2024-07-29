//
//  HomeMovieCell.swift
//  StarMovie
//
//  Created by petar on 11.04.2024.
//

import UIKit
import SnapKit

final class HomeMovieCell: UICollectionViewCell {
    
    static let id = "movieCell"
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Resources.Colors.mainColorDark
        label.textColor = Resources.Colors.mainColorLight
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Resources.Fonts.gillSansFont(size: 19, blod: false)
        return label
    }()
    
    let movieYearLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Resources.Colors.mainColorDark
        label.textColor = Resources.Colors.mainColorLight
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    override var isSelected: Bool{
        didSet{
            movieNameLabel.backgroundColor = self.isSelected ? Resources.Colors.accentColor : Resources.Colors.mainColorDark
            movieYearLabel.backgroundColor = self.isSelected ? Resources.Colors.accentColor : Resources.Colors.mainColorDark
            movieNameLabel.textColor = self.isSelected ? Resources.Colors.mainColorDark : Resources.Colors.mainColorLight
            movieYearLabel.textColor = self.isSelected ? Resources.Colors.mainColorDark : Resources.Colors.mainColorLight
        }
    }
    
    
    func getDataForCollectionViewCell(imagePath: String, filmName: String, dateRelis: String){
        movieImageView.getImageMovie(url: imagePath, plaseholderImage: UIImage(named: "plaseholderIconDark")!)
        movieNameLabel.text = filmName
        movieYearLabel.text = dateRelis
    }
}

private extension HomeMovieCell {
    func setupConstrainsts(){
        contentView.addSubviews(movieImageView, movieNameLabel, movieYearLabel)
        
        movieImageView.snp.makeConstraints { image in
            image.top.leading.trailing.width.equalToSuperview()
            image.height.equalTo((contentView.bounds.height) * 0.85)
        }
        
        movieNameLabel.snp.makeConstraints { name in
            name.top.equalTo(movieImageView.snp.bottom)
            name.leading.trailing.width.equalToSuperview()
            name.height.equalTo(contentView.bounds.height * 0.10)
        }
        
        movieYearLabel.snp.makeConstraints { year in
            year.top.equalTo(movieNameLabel.snp.bottom)
            year.leading.trailing.bottom.width.equalToSuperview()
            year.height.equalTo(contentView.bounds.height * 0.05)
        }
    }
}
