//
//  DateFormatter + .swift
//  StarMovie
//
//  Created by petar on 21.09.2024.
//

import Foundation

extension DateFormatter {
    func onlyYearString(from date: Date) -> String {
        dateFormat = "yyyy"
        return string(from: date)
    }
    
    func formatedDateForPage(from date: Date) -> String {
        timeStyle = .none
        dateStyle = .medium
        return string(from: date)
    }
}
