//
//  CustomTabBar.swift
//  StarMovie
//
//  Created by petar on 19.04.2024.
//

import UIKit

final class CustomTabBar: UITabBar {
    
    override func draw(_ rect: CGRect) {
        configUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        tintColor = Resources.Colors.accentColor
        unselectedItemTintColor = Resources.Colors.mainColorLight
        itemWidth = bounds.width / 3
    }
}

//MARK: - Draw figure tabBar
private extension CustomTabBar {
    func configUI() {
        let path: UIBezierPath = getTabBarPath()
        let figure = CAShapeLayer()
        
        figure.path = path.cgPath
        figure.lineWidth = 0
        figure.strokeColor = Resources.Colors.mainColorLight.cgColor
        figure.fillColor = Resources.Colors.mainColorDark.cgColor
        layer.insertSublayer(figure, at: .zero)
    }
    
    func getTabBarPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 10, y: 30))
        path.addArc(withCenter: CGPoint(x: 40, y: 30),
                    radius: 30,
                    startAngle: .pi,
                    endAngle: 3 * .pi / 2,
                    clockwise: true)
        path.addLine(to: CGPoint(x: bounds.width - 40, y: 0))
        path.addArc(withCenter: CGPoint(x: bounds.width - 40, y: 30),
                    radius: 30,
                    startAngle: 3 * .pi / 2,
                    endAngle: 0,
                    clockwise: true)
        path.addLine(to: CGPoint(x: bounds.width - 10, y: bounds.height))
        path.addLine(to: CGPoint(x: 10, y: bounds.height))
        path.addLine(to: CGPoint(x: 10, y: 30))
        return path
    }
}
