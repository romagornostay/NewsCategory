//
//  String+Date.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 11.09.2023.
//

import Foundation

extension Date {
    func format(_ format: String = "MMM dd, yyyy - hh:mm:a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    func convertIntoDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}
