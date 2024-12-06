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
}
