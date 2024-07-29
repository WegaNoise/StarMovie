//
//  MovieScrollView.swift
//  StarMovie
//
//  Created by petar on 26.06.2024.
//

import UIKit
import SnapKit

final class MovieScrollView: UIScrollView {
    
    private let contentView: UIView = {
        let content = UIView()
        content.backgroundColor = Resources.Colors.mainColorGray
        return content
    }()
    
    private let filmNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 30, blod: true)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = Resources.Colors.mainColorLight.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 23, blod:  false)
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let releseDate = UILabel()
        releseDate.textColor = Resources.Colors.mainColorLight
        releseDate.font = Resources.Fonts.gillSansFont(size: 25, blod: true)
        releseDate.textAlignment = .center
        releseDate.numberOfLines = 0
        releseDate.text = "Relese Date:"
        return releseDate
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = Resources.Colors.accentColor
        dateLabel.font = Resources.Fonts.gillSansFont(size: 23, blod: false)
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    private let ratingProgressView = RatingProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContentInScrollView(textName: String, imagePath: String, textOverview: String, dateRelease: String, ratingValue: Double){
        filmNameLabel.text = textName
        movieImageView.getImageMovie(url: imagePath, plaseholderImage: UIImage(named: "plaseholderIconDark")!)
        overviewLabel.text = textOverview
        dateLabel.text = dateRelease
        ratingProgressView.getRatingValue(rating: ratingValue)
        addElementsInContentView()
    }
}

private extension MovieScrollView{
    func setupScrollView() {
        showsVerticalScrollIndicator = true
        alwaysBounceVertical = true
        addSubviews(contentView)
        contentView.snp.makeConstraints { content in
            content.edges.equalToSuperview()
        }
    }
    
    func addElementsInContentView(){
        contentView.addSubviews(filmNameLabel, movieImageView, overviewLabel, 
                                releaseDateLabel, dateLabel, ratingProgressView)
        
        let heightMovieName = filmNameLabel.textSizeHeight(text: filmNameLabel.text, font: filmNameLabel.font, width: UIScreen.main.bounds.width - 20)
        let heightOverview = overviewLabel.textSizeHeight(text: overviewLabel.text, font: overviewLabel.font, width: UIScreen.main.bounds.width - 20)
        
        filmNameLabel.snp.makeConstraints { label in
            label.centerX.equalToSuperview()
            label.leading.equalToSuperview().offset(10)
            label.trailing.equalToSuperview().offset(-10)
            label.width.equalTo(UIScreen.main.bounds.width - 20)
            label.height.equalTo(heightMovieName + 40)
        }
        
        movieImageView.snp.makeConstraints { imageView in
            imageView.top.equalTo(filmNameLabel.snp.bottom).offset(10)
            imageView.leading.equalToSuperview().offset(10)
            imageView.trailing.equalToSuperview().offset((-UIScreen.main.bounds.width / 2) - 10)
            imageView.height.equalTo(300)
            imageView.width.equalTo((UIScreen.main.bounds.width / 2) - 20)
        }
        
        overviewLabel.snp.makeConstraints { overview in
            overview.top.equalTo(movieImageView.snp.bottom)
            overview.left.equalToSuperview().offset(10)
            overview.right.equalToSuperview().offset(-10)
            overview.width.equalTo(UIScreen.main.bounds.width - 20)
            overview.height.equalTo(heightOverview + 20)
        }
        
        releaseDateLabel.snp.makeConstraints { relese in
            relese.top.equalTo(movieImageView.snp.top)
            relese.left.equalTo(movieImageView.snp.right).offset(10)
            relese.right.equalToSuperview().offset(-10)
        }
        
        dateLabel.snp.makeConstraints { dateRelease in
            dateRelease.top.equalTo(releaseDateLabel.snp.bottom).offset(10)
            dateRelease.left.equalTo(releaseDateLabel.snp.left)
            dateRelease.right.equalTo(releaseDateLabel.snp.right)
            dateRelease.height.equalTo(releaseDateLabel.snp.height)
        }
        
        ratingProgressView.snp.makeConstraints { rating in
            rating.top.equalTo(dateLabel.snp.bottom).offset(10)
            rating.bottom.equalTo(overviewLabel.snp.top).offset(-10)
            rating.trailing.equalToSuperview().offset(-10)
            rating.leading.equalTo(movieImageView.snp.trailing).offset(10)
        }
    }
}
