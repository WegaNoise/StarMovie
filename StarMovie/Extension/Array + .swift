//
//  Array + .swift
//  StarMovie
//
//  Created by petar on 04.12.2024.
//

import Foundation

extension Array {
    func element(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
