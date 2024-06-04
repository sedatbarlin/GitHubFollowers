//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Sedat on 4.06.2024.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
