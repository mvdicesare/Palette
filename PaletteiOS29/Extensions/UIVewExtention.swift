//
//  UIVewExtention.swift
//  PaletteiOS29
//
//  Created by Michael Di Cesare on 10/22/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, topPadding: CGFloat, bottomPadding: CGFloat, leadingPadding: CGFloat, trailingPadding: CGFloat, width: CGFloat? = nil, hight: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let hight = hight {
            self.heightAnchor.constraint(equalToConstant: hight).isActive = true
        }
    }
}

struct SpacingConstant {
    static let verticalObjectBuffer: CGFloat = 8.0
    static let outerHorizontalPadding: CGFloat = 24.0
    static let outerVerticalPadding: CGFloat = 16.0
    static let oneLineElementHight: CGFloat = 24.0
    static let twoLineElementHight: CGFloat = 32.0
    
}
