//
//  NNFW_UIScrollView.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

public class NNScrollView: UIScrollView {
    
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
    
    // Event Section
    
    public enum NNScrollViewEvent {
        case onDidScroll
        case onDidEndScroll
        case onDidScrollUp
        case onDidEndScrollUp
        case onDidScrollDown
        case onDidEndScrollDown
        case onDidScrollToTop
        case onDidEndScrollToTop
        case onDidScrollToBottom
        case onDidEndScrollToBottom
    }
    
    var onDidScroll: () -> Void = {}
    var onDidEndScroll: () -> Void = {}
    var onDidScrollUp: () -> Void = {}
    var onDidEndScrollUp: () -> Void = {}
    var onDidScrollDown: () -> Void = {}
    var onDidEndScrollDown: () -> Void = {}
    var onDidScrollToTop: () -> Void = {}
    var onDidEndScrollToTop: () -> Void = {}
    var onDidScrollToBottom: () -> Void = {}
    var onDidEndScrollToBottom: () -> Void = {}
    
    public func addEvent(_ Type: NNScrollViewEvent, _ inSegment: @escaping () -> Void) {
        
        self.delegate = self
        
        switch Type {
            
        case .onDidScroll:
            
            self.onDidScroll = inSegment
            
            break
            
        case .onDidEndScroll:
            
            self.onDidEndScroll = inSegment
            
            break
            
        case .onDidScrollUp:
            
            self.onDidScrollUp = inSegment
            
            break
            
        case .onDidEndScrollUp:
            
            self.onDidEndScrollUp = inSegment
            
            break
            
        case .onDidScrollDown:
            
            self.onDidScrollDown = inSegment
            
            break
            
        case .onDidEndScrollDown:
            
            self.onDidEndScrollDown = inSegment
            
            break
            
        case .onDidScrollToTop:
            
            self.onDidScrollToTop = inSegment
            
            break
            
        case .onDidEndScrollToTop:
            
            self.onDidEndScrollToTop = inSegment
            
            break
            
        case .onDidScrollToBottom:
            
            self.onDidScrollToBottom = inSegment
            
            break
            
        case .onDidEndScrollToBottom:
            
            self.onDidEndScrollToBottom = inSegment
            
            break
            
        }
        
    }
    
}

extension NNScrollView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.onDidScroll()
        
        let topEdge = self.contentOffset.y
        let bottomEdge = self.contentOffset.y + self.frame.size.height
        
        if (bottomEdge >= self.contentSize.height) {
            
            self.onDidScrollToBottom()
            
        }
        
        if (topEdge <= 0) {
            
            self.onDidScrollToTop()
            
        }
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 0 {
            self.onDidScrollDown()
        } else {
            self.onDidScrollUp()
        }
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.onDidEndScroll()
        
        let topEdge = self.contentOffset.y
        let bottomEdge = self.contentOffset.y + self.frame.size.height
        
        if (bottomEdge >= self.contentSize.height) {
            
            self.onDidEndScrollToBottom()
            
        }
        
        if (topEdge <= 0) {
            
            self.onDidEndScrollToTop()
            
        }
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 0 {
            self.onDidEndScrollDown()
        } else {
            self.onDidEndScrollUp()
        }
        
    }
    
}
