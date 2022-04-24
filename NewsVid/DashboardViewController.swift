//
//  DashboardViewController.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import Foundation
import UIKit

class DashboardViewController: UICollectionViewController {
    
    private let service = YoutubeService()
    private var sections = [VideoSection.main]
    private var isFetching = false
    private lazy var dataSource = makeDataSource()
    
    @MainActor var arr: [VideoSearchResult] = [] {
        didSet {
            applySnapshot()
        }
    }
    
    enum VideoSection { case main }
    typealias DataSource = UICollectionViewDiffableDataSource<VideoSection, VideoSearchResult>
    typealias Snapshot = NSDiffableDataSourceSnapshot<VideoSection, VideoSearchResult>
    
    init() {
        let layout = UICollectionViewCompositionalLayout { idx, env in
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.absolute(VideoSnippetCell.contentHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            return section
        }
        
        super.init(collectionViewLayout: layout)
        
        collectionView.register(
            VideoSnippetCell.self,
            forCellWithReuseIdentifier: VideoSnippetCell.reuseId
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Dashboard"
        view.backgroundColor = .purple
        
        isFetching = true
        Task {
            do {
                let items = try await service.searchVideoWith(query: "ukraine")
                isFetching = false
                arr = items
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isNearBottomEnd, !isFetching {
            fetchMore()
        }
    }
    
    private func fetchMore() {
        isFetching = true
        Task {
            do {
                let items = try await service.searchVideoWith(query: "ukraine")
                isFetching = false
                for item in items where !arr.contains(item) {
                    arr.append(item)
                }
            }
        }
    }
    
    private func applySnapshot() {
        var snapshots = Snapshot()
        
        snapshots.appendSections(sections)
        sections.forEach { section in
            snapshots.appendItems(arr, toSection: section)
        }
        dataSource.apply(snapshots, animatingDifferences: true)
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { cv, ip, item in
            let cell = cv.dequeueReusableCell(
                withReuseIdentifier: VideoSnippetCell.reuseId,
                for: ip
            ) as? VideoSnippetCell
            cell?.title.text = self.arr[ip.row].videoID
            cell?.desc.text = self.arr[ip.row].desc
            cell?.thumbnailImageURL = self.arr[ip.row].thumbnails
            return cell
        }
        return dataSource
    }
}

extension UIScrollView {
    var isNearBottomEnd: Bool {
        return (contentOffset.y + frame.size.height + frame.size.width / 2) > contentSize.height
    }
}
