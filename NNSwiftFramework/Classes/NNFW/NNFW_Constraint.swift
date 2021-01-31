//
//  NNFW_Constraint.swift
//
//  Created by Saharat Sittipanya on 20/10/2563 BE.
//

import UIKit

class fitToTopInsetConstraint: NSLayoutConstraint {
    
    override func awakeFromNib() {
        
        if let window = UIApplication.shared.windows.first {
            
            let topPadding = window.safeAreaInsets.top
            
            self.constant += topPadding
            
        }
        
    }
}

class fitToBottomInsetConstraint: NSLayoutConstraint {
    
    override func awakeFromNib() {
        
        if let window = UIApplication.shared.windows.first {
            
            let bottomPadding = window.safeAreaInsets.bottom
            
            self.constant += bottomPadding
            
        }
        
    }
}
