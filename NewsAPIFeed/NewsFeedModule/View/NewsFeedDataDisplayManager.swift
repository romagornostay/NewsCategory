//
//  NewsFeedDataDisplayManager.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import UIKit

protocol NewsDataDisplayManagerDelegate: AnyObject {
    
    func didTriggerCellSelected(atIndex index: Int)
    
}

final class NewsFeedDataDisplayManager: NSObject {
    
    enum Section {
        case main
    }

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, NewsViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, NewsViewModel>
    private typealias CellRegistration = UICollectionView.CellRegistration<NewsCollectionViewCell, NewsViewModel>
    
    private var dataSource: DataSource?
    
    private(set) lazy var layout: UICollectionViewLayout = createLayout()
    
    private weak var delegate: NewsDataDisplayManagerDelegate?
    private var viewModels = [NewsViewModel]()
    
    func setup(with collectionView: UICollectionView) {
        dataSource = dataSource(with: collectionView)
    }
    
    func setup(with viewModels: [NewsViewModel]) {
        self.viewModels = viewModels
        
        // initial data
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModels)
        dataSource?.apply(snapshot, animatingDifferences: false)
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
        section.interGroupSpacing = 1
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension NewsFeedDataDisplayManager {

    private func cellRegistration() -> CellRegistration {
        return CellRegistration { [weak self] (cell, indexPath, item) in
            guard let self else { return }
            cell.configure(with: viewModels[indexPath.row])
        }
    }

    private func dataSource(with collectionView: UICollectionView) -> DataSource {
        let cellRegistration = cellRegistration()

        return DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> NewsCollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }

}

extension NewsFeedDataDisplayManager: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
