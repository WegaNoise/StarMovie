//
//  UIActivityIndicatorView +.swift
//  StarMovie
//
//  Created by petar on 31.08.2024.
//

import UIKit

enum ActivityIndicatorState {
    case showAndStart
    case stopAndHidden
}

extension UIActivityIndicatorView {
    func changeState(_ state: ActivityIndicatorState) {
        switch state {
        case .showAndStart:
            self.isHidden = false
            self.startAnimating()
        case .stopAndHidden:
            self.isHidden = true
            self.stopAnimating()
        }
    }
}
