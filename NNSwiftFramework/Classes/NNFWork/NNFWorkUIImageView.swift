//
//  NNFWorkUIImageView.swift
//  BCPGEcolife
//
//  Created by Saharat Sittipanya on 11/3/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
        
    }
    
}
