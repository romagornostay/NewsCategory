//
//  SectionBackgroundDecorationView.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 24.09.2023.
//

import UIKit

class SectionBackgroundDecorationView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension SectionBackgroundDecorationView {
    func configure() {
        backgroundColor = UIColor.blue.withAlphaComponent(0.25)
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 1
        layer.cornerRadius = 12
    }
}

