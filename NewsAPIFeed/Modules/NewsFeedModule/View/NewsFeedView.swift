//
//  NewsFeedView.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 10.09.2023.
//

import UIKit

protocol NewsFeedViewOutput: AnyObject {
    func didTriggerLoadNews()
    func didTriggerCellSelected(atIndex index: Int)
    func didTriggerPullToRefresh()
}

// MARK: -
final class NewsFeedView: UIView {
    
    weak var output: NewsFeedViewOutput?
    private let viewModel: NewsFeedViewModelProtocol
    private let dataDisplayManager: NewsFeedDataDisplayManager
    
    // MARK: - Subviews
    private let collectionView: UICollectionView
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Init
    init(frame: CGRect = .zero, viewModel: NewsFeedViewModelProtocol, dataDisplayManager: NewsFeedDataDisplayManager) {
        self.viewModel = viewModel
        self.dataDisplayManager = dataDisplayManager
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: dataDisplayManager.layout)
        super.init(frame: frame)
        backgroundColor = .gradientDarkGrey
        
        setupInitialState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutCollectionView()
    }
    
    private func setupInitialState() {
        setupCollectionView()
        setupRefreshControl()
//        setupEmptyStateView()
    }
    
    private func setupCollectionView() {
        dataDisplayManager.setup(with: collectionView)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didTriggerPullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .green
        collectionView.addSubview(refreshControl)
        endRefreshing()
    }
    
    private func endRefreshing() {
        dataDisplayManager.onTopEndRefreshing = { [weak self] in
            guard let refreshControl = self?.refreshControl else { return }
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
    }
    
    private func layoutCollectionView() {
        collectionView.frame = bounds
    }
    
    // MARK: - Internal func
    func didTriggerViewReadyForLoadNews() {
        output?.didTriggerLoadNews()
    }
    
    @objc private func didTriggerPullToRefresh() {
        output?.didTriggerPullToRefresh()
    }
    
}

// MARK: - UICollectionViewDelegate
extension NewsFeedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didTriggerCellSelected(atIndex: indexPath.row)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
