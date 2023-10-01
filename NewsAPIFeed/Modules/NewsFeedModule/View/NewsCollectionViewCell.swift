//
//  NewsCollectionViewCell.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
        
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviewsForCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutCollectionViewCell()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
        
    }
    
    private func addSubviewsForCell() {
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    private func layoutCollectionViewCell() {
        let contentViewSize = contentView.frame.size
        newsTitleLabel.frame = CGRect(x: Constants.topInset,
                                      y: Constants.topInset,
                                      width: contentViewSize.width - contentViewSize.height,
                                      height: Constants.titleHeiht)
        subtitleLabel.frame = CGRect(x: Constants.topInset,
                                     y: newsTitleLabel.frame.maxY,
                                     width: contentViewSize.width - contentViewSize.height,
                                     height: contentViewSize.height/2)

        newsImageView.frame = CGRect(x: newsTitleLabel.frame.maxX + Constants.inset,
                                     y: Constants.topInset,
                                     width: contentViewSize.height - 2*Constants.topInset,
                                     height: contentViewSize.height - 2*Constants.topInset)
    }
    
    func configure(with viewModel: NewsViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if let imageData = viewModel.imageData {
            newsImageView.image = UIImage(data: imageData)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data, error == nil else { return }
//                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
    }
    
}

// MARK: - Constants
fileprivate extension NewsCollectionViewCell {
    
    enum Constants {
        
        static let imageCornerRadius: CGFloat = 10
        static let topInset: CGFloat = 10
        static let inset: CGFloat = 5
        
        static let titleHeiht: CGFloat = 50
        static let height: CGFloat = 130
        
    }
    
}

