//
//  NNFW_UITableView.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

extension UITableView {
    
    public func scrollToBottom() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
    }
    
    public func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
    }
    
}

protocol ContentFittingTableViewDelegate: UITableViewDelegate {
    func tableViewDidUpdateContentSize(_ tableView: UITableView)
}

public class NNTableView: UITableView {
    
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
    
    public func refreshNotHaveLabel(_ text: String, _ textColor: UIColor, _ font: UIFont?, _ numberOfRowsInSection: Int, _ isScrollEnabledOrigin: Bool) {
        
        if self.numberOfSections >= 1 && numberOfRowsInSection > 0 {
            
            self.isScrollEnabled = isScrollEnabledOrigin
            
            self.NotHaveLabel.removeFromSuperview()
            
        } else {
            
            NotHaveLabel.frame.size = CGSize(width: self.frame.size.width - 60.0, height: self.frame.size.height - (self.frame.size.height / 3.0))
            
            NotHaveLabel.frame.origin.x = 30
            NotHaveLabel.frame.origin.y = 50
            
            NotHaveLabel.numberOfLines = 0
            NotHaveLabel.textAlignment = .center
            NotHaveLabel.textColor = textColor
            
            NotHaveLabel.text = text
            
            if font != nil {
                NotHaveLabel.font = font
            }
            
            self.isScrollEnabled = false
            
            self.addSubview(NotHaveLabel)
            
        }
        
    }
    
}
