//
//  UiView + .swift
//  StarMovie
//
//  Created by petar on 11.04.2024.
//

import UIKit

extension UIView{
    
    @discardableResult
    func addSubviews(_ views: UIView...) -> UIView {
        for view in views{
            self.addSubview(view)
        }
        return self
    }
    
    func centerInSuperview(){
        super.inputView?.didMoveToSuperview()
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                self.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ])
        }
    }
}
