//
//  UIColor + .swift
//  StarMovie
//
//  Created by petar on 12.04.2024.
//

import UIKit

extension UIColor{
    
    //custom init with color creation by hex
    convenience init(hexString: String, alpha: CGFloat) {
           let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
           var int = UInt64()
           Scanner(string: hex).scanHexInt64(&int)
           let a, r, g, b: UInt64
           switch hex.count {
           case 3: //(12-bit)
               (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
           case 6: //(24-bit)
               (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
           case 8: //(32-bit)
               (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
           default:
               (a, r, g, b) = (255, 0, 0, 0)
           }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
       }
}


