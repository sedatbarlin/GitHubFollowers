//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Sedat on 4.06.2024.
//

import UIKit

extension UITableView{
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
