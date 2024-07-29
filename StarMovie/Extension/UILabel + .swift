//
//  UILabel + .swift
//  StarMovie
//
//  Created by petar on 29.06.2024.
//

import UIKit

extension UILabel{
    func textSizeHeight(text: String?, font: UIFont?, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byCharWrapping
        
        let sizeHeightLabel = label.frame.height
        label.removeFromSuperview()
        
        return sizeHeightLabel
    }
}
