//
//  VideoSnippetView.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import Foundation
import UIKit
import SDWebImage

class VideoSnippetCell: UICollectionViewCell {
    static let reuseId = "VideoSnippetView"
    
    var thumbnailImage: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    var desc: UILabel = UILabel()
    
    var thumbnailImageURL: URL? {
        didSet {
            thumbnailImage.sd_setImage(with: thumbnailImageURL)
        }
    }
    
    let titleFont = UIFont.systemFont(ofSize: 18, weight: .medium)
    let descFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    
    static var contentHeight: CGFloat {
        UIFont.systemFont(ofSize: 18, weight: .medium).lineHeight
        + UIFont.systemFont(ofSize: 12, weight: .regular).lineHeight
        + (UIScreen.main.bounds.width * 0.75)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(title)
        contentView.addSubview(thumbnailImage)
        contentView.addSubview(desc)
        
        thumbnailImage.contentMode = .scaleAspectFit
        thumbnailImage.setW(frame.width, andH: frame.width * 0.75)
        thumbnailImage.insideTopEdge(by: 0)
        thumbnailImage.insideLeftEdge(by: 0)
        
        title.font = titleFont
        title.setW(frame.width, andH: titleFont.lineHeight)
        title.outsideBottomEdge(of: thumbnailImage, by: 4)
        
        desc.font = descFont
        desc.setW(frame.width, andH: descFont.lineHeight)
        desc.outsideBottomEdge(of: title, by: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
