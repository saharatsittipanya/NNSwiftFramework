//
//  NNFW_UILabel.swift
//
//  Created by Saharat Sittipanya on 12/11/2563 BE.
//

import UIKit

extension UILabel {
    
    public func setColorFor(_ text: String, _ color: UIColor, _ font: UIFont?) {
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        
        let range: NSRange = attributedString.mutableString.range(of: text, options: .caseInsensitive)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        if let tempFont = font {
            attributedString.addAttribute(NSAttributedString.Key.font, value: tempFont, range: range)
        }

        self.attributedText = attributedString
        
    }
    
}

@IBDesignable
public class NNCustomLabel: UILabel {
    
    @IBInspectable public var isUnderline: Bool = false {
        didSet {
            
            self.updateUI()
            
        }
    }
    
    @IBInspectable public var isStrikethrough: Bool = false {
        didSet {
            
            self.updateUI()
            
        }
    }
    
    func updateUI() {
        
        // MARK: TEXT STYLE
        let textRange = NSMakeRange(0, self.text!.unicodeScalars.count)
        let attributedText = NSMutableAttributedString(string: text!)
        
        if isUnderline {
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        }
        
        if isStrikethrough {
            attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        }
        
        self.attributedText = attributedText
        
    }
    
}
