//
//  RatingProgressView.swift
//  StarMovie
//
//  Created by petar on 08.07.2024.
//

import UIKit
import QuartzCore

final class RatingProgressView: UIView {
    
    private let backCircleLayer = CAShapeLayer()
    private let progressCircleLayer = CAShapeLayer()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.gillSansFont(size: 19, blod: false)
        label.textAlignment = .center
        label.textColor = Resources.Colors.accentColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCircleLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getRatingValue(rating: Double) {
        setupConstraints()
        let valueRating = rating / 10
        ratingLabel.text = rating.description
        createRatingAnimation(rating: Float(valueRating))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSizeCircleLayer()
    }
}

private extension RatingProgressView {
    func configCircleLayer(){
        backCircleLayer.fillColor = UIColor.clear.cgColor
        backCircleLayer.strokeColor = Resources.Colors.ultraColorLight.cgColor
        backCircleLayer.lineCap = .round
        backCircleLayer.lineWidth = 20.0
        backCircleLayer.strokeEnd = 1.0
        
        progressCircleLayer.fillColor = UIColor.clear.cgColor
        progressCircleLayer.strokeColor = Resources.Colors.accentColor.cgColor
        progressCircleLayer.lineCap = .round
        progressCircleLayer.lineWidth = 15.0
        progressCircleLayer.strokeEnd = 0.0
        
        self.layer.addSublayer(backCircleLayer)
        self.layer.addSublayer(progressCircleLayer)
    }
    
    func updateSizeCircleLayer(){
        let circleDiameter = min(bounds.width, bounds.height) * 0.5
        let circleRadius = circleDiameter / 2
        let circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let circlePath = UIBezierPath(arcCenter: circleCenter, 
                                      radius: circleRadius,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true).cgPath
        
        backCircleLayer.path = circlePath
        progressCircleLayer.path = circlePath
    }
    
    func createRatingAnimation (rating: Float?) {
        let progressAnimationCircle = CABasicAnimation(keyPath: "strokeEnd")
        progressAnimationCircle.fromValue = 0.0
        progressAnimationCircle.toValue = rating
        progressAnimationCircle.duration = TimeInterval(floatLiteral: 1.0)
        progressAnimationCircle.fillMode = .forwards
        progressAnimationCircle.isRemovedOnCompletion = false
        
        progressCircleLayer.add(progressAnimationCircle, forKey: "animateCircle")
    }
    
    func setupConstraints() {
        addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
