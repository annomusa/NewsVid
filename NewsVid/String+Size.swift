//
//  String+Size.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import Foundation
import UIKit
import CoreGraphics

extension String {
    func widthForHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let rect: CGRect = (self as NSString).boundingRect(
            with: size,
            options: [NSStringDrawingOptions.usesLineFragmentOrigin,
                      NSStringDrawingOptions.usesFontLeading],
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        return ceil(rect.width)
    }
}
