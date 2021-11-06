//
//  UIViewExtensions.swift
//  Newly
//
//  Created by Ikmal Azman on 04/11/2021.
//

import UIKit.UIView

extension UIView {
    
    class func initFromNib< T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as! T
    }
    
    /// Add drop down shadow to view
    func dropShadow(scale: Bool = true, radius: CGFloat = 10, opacity : Float = 0.4) {
           layer.masksToBounds = false
           layer.shadowColor = UIColor.lightGray.cgColor
           layer.shadowOpacity = opacity
           layer.shadowOffset = CGSize(width: -1, height: 1)
           layer.shadowRadius = radius
           
           let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
           layer.shadowPath = shadowPath.cgPath
           layer.shouldRasterize = true
           layer.rasterizationScale = scale ? UIScreen.main.scale : 1
       }
}

