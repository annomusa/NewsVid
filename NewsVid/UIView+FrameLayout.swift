//
//  UIView+FrameLayout.swift
//  NewsVid
//
//  Created by Anno Musa on 23/04/22.
//

import Foundation
import UIKit
import QuartzCore

extension UIView {
    @discardableResult
    func with(parent: UIView) -> Self {
        parent.addSubview(self)
        return self
    }
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(x) {
            self.frame.origin.x = x
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(y) {
            self.frame.origin.y = y
        }
    }
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    @discardableResult
    func setX(_ x: CGFloat, andY y: CGFloat) -> Self {
        let f = frame
        frame = CGRect(
            x: x,
            y: y,
            width: f.size.width,
            height: f.size.height)
        return self
    }
    
    @discardableResult
    func adjustX(_ xd: CGFloat, andY yd: CGFloat) -> Self {
        setX(
            frame.origin.x + xd,
            andY: frame.origin.y + yd)
        return self
    }
    
    @discardableResult
    func setW(_ w: CGFloat, andH h: CGFloat) -> Self {
        let f = frame
        frame = CGRect(
            x: f.origin.x,
            y: f.origin.y,
            width: w,
            height: h)
        return self
    }
    
    @discardableResult
    func insideTopEdge(of v: UIView?, by spacing: CGFloat) -> Self {
        let inTargetSpace = CGPoint(x: 0, y: spacing)
        y = superview?.convert(inTargetSpace, from: v).y ?? 0.0
        return self
    }
    
    @discardableResult
    func insideRightEdge(of v: UIView?, by spacing: CGFloat) -> Self {
        let inTargetSpace = CGPoint(x: (v?.frame.size.width ?? 0.0) - spacing - frame.size.width, y: 0)
        x = superview?.convert(inTargetSpace, from: v).x ?? 0.0
        return self
    }
    
    @discardableResult
    func insideBottomEdge(of v: UIView?, by spacing: CGFloat) -> Self {
        let inTargetSpace = CGPoint(x: 0, y: (v?.frame.size.height ?? 0.0) - spacing - frame.size.height)
        y = superview?.convert(inTargetSpace, from: v).y ?? 0.0
        return self
    }
    
    @discardableResult
    func insideLeftEdge(of v: UIView?, by spacing: CGFloat) -> Self {
        let inTargetSpace = CGPoint(x: spacing, y: 0)
        x = superview?.convert(inTargetSpace, from: v).x ?? 0.0
        return self
    }
    
    @discardableResult
    func outsideTopEdge(of v: UIView?, by spacing: CGFloat) -> Self {
        let inTargetSpace = CGPoint(x: 0, y: -(spacing + frame.size.height))
        y = superview?.convert(inTargetSpace, from: v).y ?? 0.0
        return self
    }
    
    @discardableResult
    func outsideRightEdge(of v: UIView?, by spacing: CGFloat) -> Self {
        let inTargetSpace = CGPoint(x: (v?.frame.size.width ?? 0.0) + spacing, y: 0)
        x = superview?.convert(inTargetSpace, from: v).x ?? 0.0
        return self
    }
    
    @discardableResult
    func outsideBottomEdge(of v: UIView?, by spacing: CGFloat) -> Self {
        let inTargetSpace = CGPoint(x: 0, y: (v?.frame.size.height ?? 0.0) + spacing)
        y = superview?.convert(inTargetSpace, from: v).y ?? 0.0
        return self
    }
    
    @discardableResult
    func outsideLeftEdge(of v: UIView?, by spacing: CGFloat) -> Self {
        let inTargetSpace = CGPoint(x: -(spacing + frame.size.width), y: 0)
        x = superview?.convert(inTargetSpace, from: v).x ?? 0.0
        return self
    }
    
    @discardableResult
    func adjustW(_ wd: CGFloat, andH hd: CGFloat) -> Self {
        let f = frame
        frame = CGRect(
            x: f.origin.x,
            y: f.origin.y,
            width: f.size.width + wd,
            height: f.size.height + hd)
        return self
    }
    
    @discardableResult
    func setXAndYFrom(_ point: CGPoint) -> Self {
        setX(point.x, andY: point.y)
        return self
    }
    
    @discardableResult
    func adjustX(_ xd: CGFloat) -> Self {
        adjustX(xd, andY: 0)
        return self
    }
    
    @discardableResult
    func adjustY(_ yd: CGFloat) -> Self {
        adjustX(0, andY: yd)
        return self
    }
    
    @discardableResult
    func scaleProportionally(byPercent factor: CGFloat) -> Self {
        setW(frame.size.width * factor, andH: frame.size.height * factor)
        return self
    }
    
    @discardableResult
    func scaleProportionally(toWidth w: CGFloat) -> Self {
        let newH = (w / frame.size.width) * frame.size.height
        setW(w, andH: newH)
        return self
    }
    
    @discardableResult
    func scaleProportionally(toHeight h: CGFloat) -> Self {
        let newW = (h / frame.size.height) * frame.size.width
        setW(newW, andH: h)
        return self
    }
    
    @discardableResult
    func centerX(with v: UIView?) -> Self {
        var c = superview?.convert(v?.center ?? CGPoint.zero, from: v?.superview)
        c?.y = center.y
        center = c ?? CGPoint.zero
        return self
    }
    
    @discardableResult
    func centerY(with v: UIView?) -> Self {
        var c = superview?.convert(v?.center ?? CGPoint.zero, from: v?.superview)
        c?.x = center.x
        center = c ?? CGPoint.zero
        return self
    }
    
    @discardableResult
    func center(with v: UIView?) -> Self {
        let c = superview?.convert(v?.center ?? CGPoint.zero, from: v?.superview)
        center = c ?? CGPoint.zero
        return self
    }
    
    @discardableResult
    func center(in r: CGRect) -> Self {
        let centerX = r.midX - r.origin.x
        let centerY = r.midY - r.origin.y
        center = CGPoint(x: centerX, y: centerY)
        return self
    }
    
    @discardableResult
    func centerX(in r: CGRect) -> Self {
        let centerX = r.midX
        var f = frame
        f.origin.x = (centerX - (f.size.width / 2)) - r.origin.x
        frame = f
        return self
    }
    
    @discardableResult
    func centerY(in r: CGRect) -> Self {
        let centerY = r.midY
        frame.origin.y = (centerY - (frame.size.height / 2)) - r.origin.y
        return self
    }
    
    @discardableResult
    func insideTopEdge(by spacing: CGFloat) -> Self {
        insideTopEdge(of: superview, by: spacing)
        return self
    }
    
    @discardableResult
    func insideRightEdge(by spacing: CGFloat) -> Self {
        insideRightEdge(of: superview, by: spacing)
        return self
    }
    
    @discardableResult
    func insideBottomEdge(by spacing: CGFloat) -> Self {
        insideBottomEdge(of: superview, by: spacing)
        return self
    }
    
    @discardableResult
    func insideLeftEdge(by spacing: CGFloat) -> Self {
        insideLeftEdge(of: superview, by: spacing)
        return self
    }
    
    @discardableResult
    func outsideTopEdge(by spacing: CGFloat) -> Self {
        outsideTopEdge(of: superview, by: spacing)
        return self
    }
    
    @discardableResult
    func outsideRightEdge(by spacing: CGFloat) -> Self {
        outsideRightEdge(of: superview, by: spacing)
        return self
    }
    
    @discardableResult
    func outsideBottomEdge(by spacing: CGFloat) -> Self {
        outsideBottomEdge(of: superview, by: spacing)
        return self
    }
    
    @discardableResult
    func outsideLeftEdge(by spacing: CGFloat) -> Self {
        outsideLeftEdge(of: superview, by: spacing)
        return self
    }
    
    @discardableResult
    func setW(_ w: CGFloat) -> Self {
        setW(w, andH: frame.size.height)
        return self
    }
    
    @discardableResult
    func setH(_ h: CGFloat) -> Self {
        setW(frame.size.width, andH: h)
        return self
    }
    
    @discardableResult
    func adjustW(_ wd: CGFloat) -> Self {
        adjustW(wd, andH: 0)
        return self
    }
    
    @discardableResult
    func adjustH(_ hd: CGFloat) -> Self {
        adjustW(0, andH: hd)
        return self
    }
    
    @discardableResult
    func setSizeFrom(_ size: CGSize) -> Self {
        var f = frame
        f.size = size
        frame = f
        return self
    }
    
    @discardableResult
    func setSizeFrom(_ v: UIView?) -> Self {
        var f = frame
        f.size = v?.frame.size ?? CGSize.zero
        frame = f
        return self
    }
    
    func maxX() -> CGFloat {
        return frame.maxX
    }
    
    func maxY() -> CGFloat {
        return frame.maxY
    }
    
    func aspectRatio() -> CGFloat {
        return frame.size.width / frame.size.height
    }
    
    func `is`(inside view: UIView?) -> Bool {
        let p = superview?.convert(frame.origin, to: view)
        return ((p?.y ?? 0.0) < (view?.frame.size.height ?? 0.0) && (p?.y ?? 0.0) < 0) || ((p?.x ?? 0.0) > 0 && (p?.x ?? 0.0) < (view?.frame.size.width ?? 0.0))
        
    }
    
    @discardableResult
    func removeSubviews() -> Self {
        subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        return self
    }
    
    func accessibilityLabels() -> [String]? {
        var labels: [String] = []
        subviews.forEach { sub in
            if let accessibilityLabels = sub.accessibilityLabels() {
                labels.append(contentsOf: accessibilityLabels)
            }
        }
        if let accessibilityLabel = accessibilityLabel {
            labels.append(accessibilityLabel)
        }
        return labels
    }
}
