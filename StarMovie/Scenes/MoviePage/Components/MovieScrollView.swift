//
//  MovieScrollView.swift
//  StarMovie
//
//  Created by petar on 26.06.2024.
//

import UIKit
import SnapKit
import youtube_ios_player_helper

protocol MovieScrollViewProtocol: AnyObject {
    func pressedButtonAddMovie()
    func starRatingChanged(newValue: Int)
}

final class MovieScrollView: UIScrollView {
    
    weak var movieScrollDelegate: MovieScrollViewProtocol?
    
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
        label.textAlignment = .justified
        return label
    }()

    private let infoDataView = UIView()
    
    private let titleReleaseDateLabel: UILabel = {
        let releseDate = UILabel()
        releseDate.textColor = Resources.Colors.mainColorLight
        releseDate.font = Resources.Fonts.gillSansFont(size: 25, blod: true)
        releseDate.textAlignment = .center
        releseDate.numberOfLines = 0
        releseDate.text = "Release Date:"
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
    
    private let dateFormatter = DateFormatter()
    
    private let ratingProgressView = RatingProgressView()
    
    private let langTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 25, blod: true)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Lang: "
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.accentColor
        label.font = Resources.Fonts.gillSansFont(size: 30, blod: false)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let playerViewContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1.5
        view.layer.borderColor = Resources.Colors.mainColorLight.cgColor
        view.backgroundColor = Resources.Colors.mainColorDark
        return view
    }()
    
    private lazy var playerYT = YTPlayerView()
    
    private lazy var playerErrorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "StarMovie?")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var watchLaterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Resources.Colors.ultraColorLight
        button.layer.cornerRadius = 12
        button.setTitleColor(Resources.Colors.accentColor, for: .normal)
        button.titleLabel?.font = Resources.Fonts.gillSansFont(size: 23, blod: false)
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.tintColor = Resources.Colors.accentColor
        button.addTarget(self, action: #selector(pressedWatchLaterButton), for: .touchUpInside)
        return button
    }()
    
    private let fiveStarView = FiveStarsRatingButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContentInScrollView(movie: Movie) {
        filmNameLabel.text = movie.title
        movieImageView.getImageMovie(url: movie.posterPath ?? " - ", plaseholderImage: UIImage(named: "plaseholderIconDark")!)
        overviewLabel.text = movie.overview
        dateLabel.text = dateFormatter.formatedDateForPage(from: movie.releaseDate ?? Date())
        ratingProgressView.getRatingValue(rating: movie.voteAverage ?? 0)
        setConfigWatchLaterButton(config: movie.watchLaterButton ?? Resources.WatchLaterButton.notInLibrary.config)
        fiveStarView.setupUserMark(mark: movie.userRating)
        languageLabel.text = movie.lang?.uppercased()
        configPlayerView(trailerID: movie.trailerID)
        addElementsInContentView()
    }
    
    func setConfigWatchLaterButton(config: [String]) {
        watchLaterButton.setTitle(config[0], for: .normal)
        watchLaterButton.setImage(UIImage(systemName: config[1]), for: .normal)
    }
    
    @objc
    func pressedWatchLaterButton() {
        movieScrollDelegate?.pressedButtonAddMovie()
    }
}

private extension MovieScrollView {
    func setupScrollView() {
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = true
        fiveStarView.fiveStarsDelegare = self
        addSubviews(contentView)
        contentView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.edges.equalToSuperview()
        }
    }
    
    func configPlayerView(trailerID: String?) {
        playerViewContainer.subviews.forEach { $0.removeFromSuperview() }
        guard let id = trailerID, !id.isEmpty else {
            playerViewContainer.addSubview(playerErrorImageView)
            playerErrorImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
            return
        }
        playerViewContainer.addSubview(playerYT)
        playerYT.load(withVideoId: id)
        playerYT.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func addElementsInContentView() {
        let screenSize = UIScreen.main.bounds.size
        contentView.addSubviews(filmNameLabel,
                                movieImageView,
                                overviewLabel,
                                infoDataView.addSubviews(
                                    titleReleaseDateLabel,
                                    dateLabel,
                                    ratingProgressView,
                                    langTitleLabel,
                                    languageLabel),
                                playerViewContainer,
                                watchLaterButton,
                                fiveStarView)
        
        filmNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(filmNameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(300)
            make.width.equalTo((screenSize.width / 2) - 20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
        }
        
        infoDataView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.top)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(movieImageView.snp.trailing).offset(10)
            make.bottom.equalTo(movieImageView.snp.bottom)
        }
        
        titleReleaseDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleReleaseDateLabel.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        langTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalTo(titleReleaseDateLabel.snp.centerX)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.leading.equalTo(langTitleLabel.snp.trailing).offset(20)
            make.bottom.equalTo(langTitleLabel.snp.bottom)
        }

        ratingProgressView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(-20)
            make.bottom.equalTo(langTitleLabel.snp.top).offset(20)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        playerViewContainer.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(overviewLabel.snp.bottom).offset(10)
            make.height.equalTo(250)
        }
        
        watchLaterButton.snp.makeConstraints { make in
            make.top.equalTo(playerViewContainer.snp.bottom).inset(-20)
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(playerViewContainer.snp.height).multipliedBy(0.2)
        }
        
        fiveStarView.snp.makeConstraints { make in
            make.top.equalTo(watchLaterButton.snp.bottom).inset(-20)
            make.directionalHorizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(watchLaterButton.snp.height)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

extension MovieScrollView: FiveStarsRatingProtocol {
    func changeStarRating(newValue: Int) {
        movieScrollDelegate?.starRatingChanged(newValue: newValue)
    }
}
