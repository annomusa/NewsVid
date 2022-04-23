//
//  VideoSnippetView.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import Foundation
import UIKit

@MainActor
class VideoSnippetView: UICollectionViewCell {
    static let reuseId = "VideoSnippetView"
    
    var label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        let height = font.lineHeight
        
        label.font = font
        label.setW(self.width, andH: height)
        label.center(with: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
