//
//  ErrorView.swift
//  StarMovie
//
//  Created by petar on 29.09.2024.
//

import UIKit
import SnapKit

final class ErrorView: UIView {
    
    private let imageError: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelError: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 20, blod: true)
        label.textAlignment = .center
        return label
    }()
    
    private let labelErrorDiscription: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.mainColorLight
        label.font = Resources.Fonts.gillSansFont(size: 18, blod: false)
        label.textAlignment = .natural
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
    }
    
    func configView(error: NetworkErrors) {
        switch error {
        case .networkConnectionError:
            imageError.image = UIImage(named: "StarNetwork")
            labelError.text = "No internet connection"
            labelErrorDiscription.text = "Please check your internet connection and try again."
        case .invalidData:
            imageError.image = UIImage(named: "StarMovieDeck")
            labelError.text = "Data not found"
            labelErrorDiscription.text = "The data could not be retrieved or was corrupted."
        case .invalidURL:
            imageError.image = UIImage(named: "StarQuestion")
            labelError.text = "Failed to connect to storage"
            labelErrorDiscription.text = "The storage is not available or cannot provide the data."
        case .invalidJSON:
            imageError.image = UIImage(named: "StarQuestion")
            labelError.text = "Received data error"
            labelErrorDiscription.text = "The received data contains an error and cannot be displayed."
        case .timeOutError:
            imageError.image = UIImage(named: "StarNetwork")
            labelError.text = "Time out error"
            labelErrorDiscription.text = "Storage access time request exceeded, please try again later."
        case .trailerNotFound:
            imageError.image = UIImage(named: "StarMovie?")
        case .unknownError:
            imageError.image = UIImage(named: "StarError")
            labelError.text = "Unknown error"
            labelErrorDiscription.text = "Received an unknown error, try again later."
        }
    }
}

private extension ErrorView {
    func setupView() {
        backgroundColor = Resources.Colors.mainColorDark
        addSubviews(imageError, labelError, labelErrorDiscription)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width * 0.7)
            make.height.equalTo(UIScreen.main.bounds.width * 0.8)
        }
        
        imageError.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(25)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        labelError.snp.makeConstraints { make in
            make.top.equalTo(imageError.snp.bottom).inset(-10)
            make.directionalHorizontalEdges.equalToSuperview().inset(25)
        }
        
        labelErrorDiscription.snp.makeConstraints { make in
            make.top.equalTo(labelError.snp.bottom).inset(-10)
            make.directionalHorizontalEdges.equalToSuperview().inset(25)
            make.bottom.equalToSuperview()
        }
    }
}
