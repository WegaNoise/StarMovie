//
//  NotFoundView.swift
//  StarMovie
//
//  Created by petar on 23.11.2024.
//

import UIKit
import SnapKit

final class NotFoundView: UIView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Resources.Colors.mainColorLight
        imageView.image = UIImage(named: "StarMovieDeck")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 25, blod: true)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "There are no films here yet"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 23, blod: false)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        centerInSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func configurateDescriptionForView(description: String) {
        descriptionLabel.text = description
    }
}

private extension NotFoundView {
    func setupView() {
        backgroundColor = Resources.Colors.mainColorDark
        self.addSubviews(iconImageView, titleLabel, descriptionLabel)
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.7)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY)
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalTo(titleLabel.snp.top).offset(-10)
        }
    }
}
