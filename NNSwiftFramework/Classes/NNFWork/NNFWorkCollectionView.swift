//
//  NNFWorkCollectionView.swift
//  Surprise Rayong
//
//  Created by Saharat Sittipanya on 14/12/61.
//  Copyright © พ.ศ. 2561 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    var centerPoint : CGPoint {
        
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
        }
    }
    
    var centerCellIndexPath: IndexPath? {
        
        if let centerIndexPath = self.indexPathForItem(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }
}
