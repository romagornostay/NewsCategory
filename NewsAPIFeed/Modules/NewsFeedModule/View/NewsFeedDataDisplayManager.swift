//
//  NewsFeedDataDisplayManager.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import UIKit
import SwiftUI

protocol NewsDataDisplayManagerDelegate: AnyObject {
    
    func didTriggerCellSelected(atIndex index: Int)
    
}

final class NewsFeedDataDisplayManager: NSObject {
        
    enum Section {
        case main
    }

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, NewsViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, NewsViewModel>
    private typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, NewsViewModel>
    private typealias SkeletonCellReg = UICollectionView.CellRegistration<NewsFeedSkeletonCell, NewsViewModel>
    
    private var dataSource: DataSource?
    
    private(set) lazy var layout: UICollectionViewLayout = createLayout()
    
    private weak var delegate: NewsDataDisplayManagerDelegate?
    
    // MARK: - Callbacks
    var onTopEndRefreshing: (() -> ())?
    
    // MARK: - Data
    private var viewModels = [NewsViewModel]()
    private var state: NewsFeedViewState = .skeleton([]) {
        didSet {
            switch state {
            case .skeleton(let viewModels):
                self.viewModels = viewModels
            case .result(let viewModels):
                self.viewModels = viewModels
            case .empty: break
            }
            // initial data
            let snapshot = createSnapshotWith(viewModels)
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func setup(with collectionView: UICollectionView) {
        dataSource = dataSource(with: collectionView)
    }
    
    func setupState(_ state: NewsFeedViewState) {
        onTopEndRefreshing?()
        self.state = state
    }
    
}

extension NewsFeedDataDisplayManager {
    
    private func createLayout() -> UICollectionViewLayout {
        let height = CGFloat(130)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(height))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize,
                                                       repeatingSubitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = LayoutMetrics.groupSpacing
        section.contentInsets.leading = LayoutMetrics.horizontalMargin
        section.contentInsets.trailing = LayoutMetrics.horizontalMargin

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension NewsFeedDataDisplayManager {
    
    private func createSnapshotWith(_ viewModels: [NewsViewModel]) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModels)
        return snapshot
    }

//    private func cellRegistration() -> CellRegistration {
//        return CellRegistration { [weak self] (cell, indexPath, item) in
//            guard let self else { return }
//            cell.configure(with: viewModels[indexPath.row])
//        }
//    }
    private func cellRegistration() -> CellRegistration {
        return CellRegistration { cell, indexPath, item in
            cell.contentConfiguration = UIHostingConfiguration { NewsFeedCellView(newsViewModel: item) }
                .margins(.horizontal, LayoutMetrics.horizontalMargin)
                .background {
                    RoundedRectangle(cornerRadius: LayoutMetrics.cornerRadius, style: .continuous)
                        .fill(Color(uiColor: .secondarySystemGroupedBackground))
                }
        }
    }
    
    private func skeletonCellReg() -> SkeletonCellReg {
        return SkeletonCellReg { (cell, indexPath, item) in
            cell.update(skeletonColor: .blue)
        }
    }

    private func dataSource(with collectionView: UICollectionView) -> DataSource {
        let cellRegistration = cellRegistration()
        let skeletonCellReg = skeletonCellReg()

        return DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.state {
            case .skeleton(_):
                return collectionView.dequeueConfiguredReusableCell(using: skeletonCellReg, for: indexPath, item: item)
            case .result(_):
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            case .empty:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
    }

}

extension NewsFeedDataDisplayManager: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

fileprivate extension NewsFeedDataDisplayManager {
    
    private enum LayoutMetrics {
        static let horizontalMargin = 8.0
        static let sectionSpacing = 10.0
        static let groupSpacing = 25.0
        static let cornerRadius = 12.0
    }
    
}
