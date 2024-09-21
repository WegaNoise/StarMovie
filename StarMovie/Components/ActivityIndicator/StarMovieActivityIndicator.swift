//
//  StarMovieActivityIndicator.swift
//  StarMovie
//
//  Created by petar on 11.09.2024.
//

import UIKit
import SnapKit
import Lottie

enum ActivityIndicatorSize {
    case samll, medium, big
    var size: CGSize {
        let screenWidth = UIScreen.main.bounds.width
        
        switch self {
        case .big: 
            return CGSize(width: screenWidth / 2, height: screenWidth / 2)
        case .medium:
            return CGSize(width: screenWidth / 3, height: screenWidth / 3)
        case .samll:
            return CGSize(width: screenWidth / 4, height: screenWidth / 4)
        }
    }
}

enum StateActivityIndicator {
    case showAndAnimate
    case hideAndStop
}

final class StarMovieActivityIndicator: UIView {
    
    private let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        let animation = LottieAnimation.named("StarActivityIndicator")
        view.animation = animation
        view.loopMode = .loop
        view.animationSpeed = 0.5
        return view
    }()
    
    init(sizeView: ActivityIndicatorSize) {
        super .init(frame: .zero)
        configView(sizeView: sizeView)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 15
    }
    
    func changeStateActivityIndicator(state: StateActivityIndicator) {
        switch state {
        case .showAndAnimate:
            self.isHidden = false
            animationView.play()
        case .hideAndStop:
            self.isHidden = true
            animationView.stop()
        }
    }
}

private extension StarMovieActivityIndicator {
    func configView(sizeView: ActivityIndicatorSize) {
//        backgroundColor = Resources.Colors.mainColorDark
        alpha = 0.5
        self.snp.makeConstraints { make in
            make.size.equalTo(sizeView.size)
        }
        addAnimationViewForView()
    }
    
    func addAnimationViewForView(){
        addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.size.equalToSuperview().offset(-20)
            make.center.equalToSuperview()
        }
    }
}
