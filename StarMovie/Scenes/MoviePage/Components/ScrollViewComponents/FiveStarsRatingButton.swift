//
//  FiveStarRatingButton.swift
//  StarMovie
//
//  Created by petar on 05.08.2024.
//

import UIKit

protocol FiveStarsRatingProtocol: AnyObject {
    func changeStarRating(newValue: Int)
}

final class FiveStarsRatingButton: UIStackView {
                
    weak var fiveStarsDelegare: FiveStarsRatingProtocol?
    
    private let clearStarsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "clear"), for: .normal)
        btn.setImage(UIImage(systemName: "clear.fill"), for: .highlighted)
        btn.tintColor = Resources.Colors.mainColorLight
        btn.tag = 0
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        return btn
    }()
    
    lazy var starButton1 = createStarButton(tag: 1)
    lazy var starButton2 = createStarButton(tag: 2)
    lazy var starButton3 = createStarButton(tag: 3)
    lazy var starButton4 = createStarButton(tag: 4)
    lazy var starButton5 = createStarButton(tag: 5)
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserMark(mark: Int?) {
        let stars = [starButton1, starButton2, starButton3, starButton4, starButton5]
        guard mark != nil, mark != 0 else { return }
        for i in 0...((mark ?? 0) - 1) {
            changeStarButton(selected: true, forViews: stars[i])
        }
    }
}

private extension FiveStarsRatingButton {
    func configStackView() {
        clearStarsButton.addTarget(self, action: #selector(pressingStar), for: .touchUpInside)
        axis = .horizontal
        spacing = 12
        distribution = .fillEqually
        addArrangedSubviews(clearStarsButton, starButton1, starButton2, starButton3, starButton4, starButton5)
    }
    
    @objc
    func pressingStar(_ sender: UIButton) {
        switch (sender.tag) {
        case 0:
            changeStarButton(selected: false, forViews: starButton1, starButton2,starButton3, starButton4, starButton5)
            fiveStarsDelegare?.changeStarRating(newValue: 0)
        case 1:
            changeStarButton(selected: true, forViews: starButton1)
            changeStarButton(selected: false, forViews: starButton2, starButton3, starButton4, starButton5)
            fiveStarsDelegare?.changeStarRating(newValue: 1)
        case 2:
            changeStarButton(selected: true, forViews: starButton1, starButton2)
            changeStarButton(selected: false, forViews: starButton3, starButton4, starButton5)
            fiveStarsDelegare?.changeStarRating(newValue: 2)
        case 3:
            changeStarButton(selected: true, forViews: starButton1, starButton2,starButton3)
            changeStarButton(selected: false, forViews: starButton4, starButton5)
            fiveStarsDelegare?.changeStarRating(newValue: 3)
        case 4:
            changeStarButton(selected: true, forViews: starButton1, starButton2,starButton3, starButton4)
            changeStarButton(selected: false, forViews: starButton5)
            fiveStarsDelegare?.changeStarRating(newValue: 4)
        case 5:
            changeStarButton(selected: true, forViews: starButton1, starButton2,starButton3, starButton4, starButton5)
            fiveStarsDelegare?.changeStarRating(newValue: 5)
        default:
            changeStarButton(selected: false, forViews: starButton1, starButton2,starButton3, starButton4, starButton5)
        }
    }
    
    func changeStarButton(selected: Bool,forViews: UIButton...) {
        for view in forViews {
            view.setImage(selected ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
            view.tintColor = selected ? Resources.Colors.accentColor : Resources.Colors.mainColorLight
        }
    }
    
    func createStarButton(tag: Int) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.setImage(UIImage(systemName: "star.fill"), for: .highlighted)
        btn.tintColor = Resources.Colors.mainColorLight
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.tag = tag
        btn.addTarget(self, action: #selector(pressingStar), for: .touchUpInside)
        return btn
    }
}

extension FiveStarsRatingButton {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
