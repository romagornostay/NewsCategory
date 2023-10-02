//
//  NewsFeedSkeletonCell.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 19.09.2023.
//

import UIKit

class NewsFeedSkeletonCell: UICollectionViewCell {
        
    private let newsTitleLabel = SkeletonView()
    private let subtitleLabel = SkeletonView()
    private let newsImageView = SkeletonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInitialState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupCornerRadius()
        layoutCollectionViewCell()
    }
    
    private func setupInitialState() {
        backgroundColor = .brown
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    private func layoutCollectionViewCell() {
        let contentViewSize = contentView.frame.size
        newsTitleLabel.frame = CGRect(x: Constants.inset,
                                      y: Constants.topInset,
                                      width: contentViewSize.width - contentViewSize.height,
                                      height: Constants.titleHeiht)
        subtitleLabel.frame = CGRect(x: Constants.inset,
                                     y: newsTitleLabel.frame.maxY + Constants.inset,
                                     width: contentViewSize.width - contentViewSize.height,
                                     height: Constants.subtitleHeiht)
        
        newsImageView.frame = CGRect(x: newsTitleLabel.frame.maxX + Constants.inset,
                                     y: Constants.inset,
                                     width: contentViewSize.height - 2*Constants.topInset,
                                     height: contentViewSize.height - 2*Constants.topInset)
    }
    
    private func setupCornerRadius() {
        newsTitleLabel.layer.cornerRadius = Constants.titleCornerRadius
        subtitleLabel.layer.cornerRadius = Constants.titleCornerRadius
        newsImageView.layer.cornerRadius = Constants.imageCornerRadius
    }
    
    func update(backgroundColor: UIColor = .clear, skeletonColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        if let skeletonColor = skeletonColor {
            newsTitleLabel.backgroundColor = skeletonColor
            subtitleLabel.backgroundColor = skeletonColor
            newsImageView.backgroundColor = skeletonColor
        }
        setNeedsLayout()
    }
    
}

// MARK: - Constants
fileprivate extension NewsFeedSkeletonCell {
    
    enum Constants {
        
        static let imageCornerRadius: CGFloat = 10
        static let titleCornerRadius: CGFloat = 5
        static let topInset: CGFloat = 12
        static let inset: CGFloat = 10
        
        static let titleHeiht: CGFloat = 40
        static let subtitleHeiht: CGFloat = 50
        
    }
    
}
