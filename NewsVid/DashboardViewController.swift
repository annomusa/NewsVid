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
    private lazy var dataSource = makeDataSource()
    
    enum VideoSection { case main }
    
    typealias DataSource = UICollectionViewDiffableDataSource<VideoSection, VideoSearchResult>
    typealias Snapshot = NSDiffableDataSourceSnapshot<VideoSection, VideoSearchResult>
    
    init() {
        let layout = UICollectionViewCompositionalLayout { idx, env in
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.absolute(24)
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
            VideoSnippetView.self,
            forCellWithReuseIdentifier: VideoSnippetView.reuseId
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            do {
                let items = try await service.searchVideoWith(query: "ukraine")
                arr = items
            }
        }
    }
    
    @MainActor var arr: [VideoSearchResult] = [] {
        didSet {
            applySnapshot()
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
                withReuseIdentifier: VideoSnippetView.reuseId,
                for: ip
            ) as? VideoSnippetView
            cell?.label.text = self.arr[ip.row].videoID
            return cell
        }
        return dataSource
    }
}
