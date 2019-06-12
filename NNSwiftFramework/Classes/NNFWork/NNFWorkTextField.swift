//
//  NNFWorkTextField.swift
//  4SCTF
//
//  Created by Saharat Sittipanya on 6/2/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
//    @IBInspectable var placeHolderColor: UIColor? {
//        get {
//            return self.placeHolderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
//        }
//    }
    
}

enum placeholderDirection: String {
    case placeholderUp = "up"
    case placeholderDown = "down"
    
}

class NNInputLayoutTextFiled: UITextField {
    
    var enableMaterialPlaceHolder : Bool = true
    var placeholderAttributes = NSDictionary()
    var lblPlaceHolder = UILabel()
    var defaultFont = UIFont()
    var difference: CGFloat = 35.0
    var directionMaterial = placeholderDirection.placeholderUp
    var isUnderLineAvailabe : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Initialize ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Initialize ()
    }
    
    func Initialize(){
        self.clipsToBounds = false
        self.addTarget(self, action: #selector(NNInputLayoutTextFiled.textFieldDidChange), for: .editingChanged)
        self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: true)
        if isUnderLineAvailabe {
            let underLine = UIImageView()
            underLine.backgroundColor = UIColor.init(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 0.8)
            underLine.frame = CGRect(x: 0, y: self.frame.size.height-1, width : self.frame.size.width, height : 1)
            
            underLine.clipsToBounds = true
            self.addSubview(underLine)
        }
        defaultFont = self.font!
        
    }
    
    override internal var placeholder: String?  {
        didSet {
            //  NSLog("placeholder = \(placeholder)")
        }
        willSet {
            let atts  = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.labelFontSize] as [NSAttributedString.Key : Any]
            self.attributedPlaceholder = NSAttributedString(string: newValue!, attributes: atts)
            self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
        }
        
    }
    
    @IBInspectable var placeHolderColor: UIColor? = UIColor.lightGray {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder! as String, attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor!])
        }
    }
    
    override internal var attributedText: NSAttributedString?  {
        didSet {
            //  NSLog("text = \(text)")
        }
        willSet {
            if (self.placeholder != nil) && (self.text != "")
            {
                let string = NSString(string : self.placeholder!)
                self.placeholderText(string)
            }
            
        }
    }
    
    @objc func textFieldDidChange(){
        if self.enableMaterialPlaceHolder {
            if (self.text == nil) || (self.text?.count)! > 0 {
                self.lblPlaceHolder.alpha = 1
                self.attributedPlaceholder = nil
                self.lblPlaceHolder.textColor = self.placeHolderColor
                let fontSize = self.font!.pointSize;
                self.lblPlaceHolder.font = UIFont.init(name: (self.font?.fontName)!, size: fontSize-3)
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
                if (self.text == nil) || (self.text?.count)! <= 0 {
                    self.lblPlaceHolder.font = self.defaultFont
                    self.lblPlaceHolder.frame = CGRect(x: self.lblPlaceHolder.frame.origin.x, y : 0, width :self.frame.size.width, height : self.frame.size.height)
                }
                else {
                    if self.directionMaterial == placeholderDirection.placeholderUp {
                        self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : -self.difference, width : self.frame.size.width, height : self.frame.size.height)
                    }else{
                        self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : self.difference, width : self.frame.size.width, height : self.frame.size.height)
                    }
                    
                }
            }, completion: {(finished: Bool) -> Void in
            })
        }
    }
    
    func EnableMaterialPlaceHolder(enableMaterialPlaceHolder: Bool){
        self.enableMaterialPlaceHolder = enableMaterialPlaceHolder
        self.lblPlaceHolder = UILabel()
        self.lblPlaceHolder.frame = CGRect(x: 0, y : 0, width : 0, height :self.frame.size.height)
        self.lblPlaceHolder.font = UIFont.systemFont(ofSize: 10)
        self.lblPlaceHolder.alpha = 0
        self.lblPlaceHolder.clipsToBounds = true
        self.addSubview(self.lblPlaceHolder)
        self.lblPlaceHolder.attributedText = self.attributedPlaceholder
    }
    
    func placeholderText(_ placeholder: NSString){
        
        let atts  = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.labelFontSize] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: placeholder as String , attributes:atts)
        self.EnableMaterialPlaceHolder(enableMaterialPlaceHolder: self.enableMaterialPlaceHolder)
        
    }
    
    override func becomeFirstResponder()->(Bool){
        let returnValue = super.becomeFirstResponder()
        return returnValue
    }
    
    override func resignFirstResponder()->(Bool){
        let returnValue = super.resignFirstResponder()
        return returnValue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

class NNActionTextField: UITextField, UITextFieldDelegate {
    
    var on_textFieldEditingChanged: () -> Void = {}
    var on_textFieldShouldReturn: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Initialize ()
        
        self.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Initialize ()
        
        self.delegate = self
        
    }
    
    func Initialize() {
        
        self.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange() {
        
        self.on_textFieldEditingChanged()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.on_textFieldShouldReturn()
        
        self.endEditing(true)
        
        return true
        
    }
    
}

class validatedTextField: UITextField {
    
    @IBInspectable var maximumCharecter: Int = Int.max {
        
        didSet {
            
            self.addTarget(self, action: #selector(self.validatingSize), for: .editingChanged)
            
        }
        
    }
    
    @IBInspectable var minimumCharecter: Int = 0 {
        
        didSet {
            
            
            
        }
        
    }
    
    @objc func validatingSize() {
        
        if self.text!.count > self.maximumCharecter {
            
            let subStr = Array(self.text!)
            self.text = String(subStr[..<self.maximumCharecter])
            
        }
        
    }
    
    func validatingMinSize() -> Bool {
        
        return self.text!.count >= self.minimumCharecter
        
    }
    
}
