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
}

