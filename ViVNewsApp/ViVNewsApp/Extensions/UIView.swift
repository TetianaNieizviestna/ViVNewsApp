//
//  UIView.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import UIKit

extension UIView {
    func setCornersRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func roundCorners() {
        superview?.layoutIfNeeded()
        setCornersRadius(frame.height / 2)
    }
}
