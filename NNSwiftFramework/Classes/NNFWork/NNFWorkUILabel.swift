//
//  NNFWorkUILabel.swift
//  BCPGEcolife
//
//  Created by Saharat Sittipanya on 25/3/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class NNCustomLabel: UILabel {
    
    @IBInspectable var underlinedText: Bool = false {
        didSet {
            
            guard let text = self.text else { return }
            
            let textRange = NSMakeRange(0, text.count)
            
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: textRange)
            
            self.attributedText = attributedText
            
        }
    }
    
}

extension UILabel {
    
    func addUnderline(with style: NSUnderlineStyle = .single, startAt startIndex: Int = 0, to endIndex: Int = -1) {
        
        if let text = self.text {
            
            let textRange = NSMakeRange(startIndex, endIndex == -1 ? text.count:endIndex + 1)
            
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: style.rawValue, range: textRange)
            
            self.attributedText = attributedText
            
        }
        
    }
    
}
