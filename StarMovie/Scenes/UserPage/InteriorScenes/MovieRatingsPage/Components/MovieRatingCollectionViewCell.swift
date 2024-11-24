//
//  MovieRatingCollectionViewCell.swift
//  StarMovie
//
//  Created by petar on 18.11.2024.
//

import UIKit
import SnapKit

final class MovieRatingCollectionViewCell: UICollectionViewCell {
    static let id = "RatingMovieCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 25, blod: true)
        label.textColor = Resources.Colors.mainColorLight
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let movieYearLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 20, blod: false)
        label.textColor = Resources.Colors.ultraColorLight
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingMovieLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 40, blod: false)
        label.textColor = Resources.Colors.accentColor
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = self.isHighlighted ? Resources.Colors.accentColor : Resources.Colors.mainColorDark
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    func configurateCell(with movie: MovieEntity?) {
        guard let movie else { return }
        let dateFormatter = DateFormatter()
        posterImageView.image = UIImage(data: movie.posterData ?? Data())
        titleLabel.text = movie.title
        movieYearLabel.text = dateFormatter.onlyYearString(from: movie.releaseDate ?? Date())
        ratingMovieLabel.text = "\(String(movie.userRating))/5"
    }
}

private extension MovieRatingCollectionViewCell {
    func initialize() {
        backgroundColor = Resources.Colors.mainColorDark
        layoutComponents()
    }
    
    func layoutComponents() {
        let contentViewWidth = contentView.bounds.width
        contentView.addSubviews(posterImageView,
                                ratingMovieLabel,
                                titleLabel,
                                movieYearLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(contentViewWidth / 4)
        }
        
        ratingMovieLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalTo(contentViewWidth / 4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(contentView.snp.centerY)
            make.leading.equalTo(posterImageView.snp.trailing)
            make.trailing.equalTo(ratingMovieLabel.snp.leading)
        }
        
        movieYearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(titleLabel)
        }
    }
}
