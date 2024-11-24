//
//  WatchLaterCollectionViewCell.swift
//  StarMovie
//
//  Created by petar on 12.11.2024.
//

import UIKit
import SnapKit

protocol WatchLaterCollectionViewCellDelegate: AnyObject {
    func didTapIsWatched(cell: WatchLaterCollectionViewCell)
}

final class WatchLaterCollectionViewCell: UICollectionViewCell {
    
    static let id = "WatchLaterCell"
    
    weak var delegate: WatchLaterCollectionViewCellDelegate?
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 23, blod: true)
        label.textColor = Resources.Colors.mainColorLight
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let movieYearLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 14, blod: false)
        label.textColor = Resources.Colors.mainColorLight
        label.textAlignment = .left
        return label
    }()
    
    private let movieLanguageLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 14, blod: false)
        label.textColor = Resources.Colors.mainColorLight
        label.textAlignment = .left
        return label
    }()
    
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.tintColor = Resources.Colors.mainColorLight
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        return button
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
    
    func configurateCell(movie: MovieEntity) {
        posterImageView.image = UIImage(data: movie.posterData ?? Data())
        movieTitleLabel.text = movie.title
        let releaseDate = DateFormatter().onlyYearString(from: movie.releaseDate ?? Date())
        movieYearLabel.text = releaseDate
        movieLanguageLabel.text = movie.lang?.uppercased()
        checkBoxButton.isSelected = movie.isWatched
    }
}

private extension WatchLaterCollectionViewCell {
    func initialize() {
        backgroundColor = Resources.Colors.mainColorDark
        addComponents()
    }
    
    func addComponents() {
        contentView.addSubviews(posterImageView, movieTitleLabel, movieYearLabel, movieLanguageLabel, checkBoxButton)
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(contentView.bounds.width / 4)
        }
        
        checkBoxButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(contentView.bounds.width / 7)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(checkBoxButton.snp.leading).offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        
        movieLanguageLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(checkBoxButton.snp.leading).offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        movieYearLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(checkBoxButton.snp.leading).offset(-10)
            make.bottom.equalTo(movieLanguageLabel.snp.top).offset(-10)
        }
    }
    
    @objc
    func checkboxTapped() {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
        delegate?.didTapIsWatched(cell: self)
    }
}
