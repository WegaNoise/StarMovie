//
//  UiView + .swift
//  StarMovie
//
//  Created by petar on 11.04.2024.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...){
        for view in views{
            self.addSubview(view)
        }
    }
}
