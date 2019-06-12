//
//  NNFWorkUITableView.swift
//  4SCTF
//
//  Created by Saharat Sittipanya on 6/3/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import UIKit
import Foundation

extension UITableView {

    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
}

class NNTableView: UITableView {
    
    // --> Init Refresher
    
    let refresher = UIRefreshControl()
    var refreshingFunction: (() -> Void) = { }
    
    func addRefresher(with action: @escaping (() -> Void)) {
        
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)
        refreshControl = refresher
        
        refreshingFunction = action
        
    }
    
    @objc func refreshing() {

        refresher.beginRefreshing()
        refreshingFunction()
        refresher.endRefreshing()
        
    }
    
}
