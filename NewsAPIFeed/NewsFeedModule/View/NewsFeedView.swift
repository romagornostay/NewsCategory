//
//  NewsFeedView.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 10.09.2023.
//

import UIKit

protocol NewsFeedViewDelegate: AnyObject {
    func didTriggerCellSelected(atIndex index: Int)
    func didTriggerPullToRefresh()
}

// MARK: -
class NewsFeedView: UIView {
    
    weak var delegate: NewsFeedViewDelegate?
    private let viewModel: NewsFeedViewModelProtocol
    private let dataDisplayManager: NewsFeedDataDisplayManager
    private let collectionView: UICollectionView
    
    init(frame: CGRect = .zero, viewModel: NewsFeedViewModelProtocol, dataDisplayManager: NewsFeedDataDisplayManager) {
        self.viewModel = viewModel
        self.dataDisplayManager = dataDisplayManager
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: dataDisplayManager.layout)
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        layoutCollectionView()
    }
    
    private func setupCollectionView() {
        dataDisplayManager.setup(with: collectionView)
        addSubview(collectionView)
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
    
    private func layoutCollectionView() {
        collectionView.frame = bounds
    }
    
}
