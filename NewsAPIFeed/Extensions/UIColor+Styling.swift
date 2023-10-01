//
//  UIColor+Styling.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 19.09.2023.
//

import UIKit

// MARK: -
extension UIColor {
    
    static let collectionViewCellBackground = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .black : .white
    }
    
    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }
    
    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
    
}
