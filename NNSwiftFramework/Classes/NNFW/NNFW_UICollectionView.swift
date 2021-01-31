//
//  NNFW_UICollectionView.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

public class NNCollectionView: UICollectionView {
    
    // Refresher Section
    
    let refresher = UIRefreshControl()
    
    var reloadTimer: Timer?
    
    var isPaning = false
    
    var refreshingFunction: (() -> Void) = { }
    
    /// Init Refresher
    public func addRefresher(with action: @escaping (() -> Void)) {
        
        refresher.attributedTitle = NSAttributedString(string: "")
        
        refresher.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)
        
        refresher.addTarget(self, action: #selector(self.Panning), for: .allEvents)
        
        refreshControl = refresher
        
        refreshingFunction = action
        
    }
    
    @objc func refreshing() {
        
        reloadTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.DidEndRefresh), userInfo: nil, repeats: true)
        
    }
    
    @objc func DidEndRefresh() {
        
        if !self.isPaning {
            
            refresher.endRefreshing()
            
            reloadTimer?.invalidate()
            
            refreshingFunction()
            
        } else {
            
            self.isPaning = false
            
        }
        
    }
    
    @objc func Panning() {
        
        self.isPaning = true
        
    }
    
    // HotHave Label Section
    
    let NotHaveLabel = UILabel()
    
    var isScrollEnabledOrigin: Bool!
    
    var reloadDataOrigin: () -> Void = {}
    
    var isReloadData = false
    
}
