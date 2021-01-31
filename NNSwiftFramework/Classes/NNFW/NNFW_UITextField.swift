//
//  NNFW_UITextField.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

public class NNActionTextField: UITextField, UITextFieldDelegate {
    
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
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.on_textFieldShouldReturn()
        
        self.endEditing(true)
        
        return true
        
    }
    
}

public class NNCurencyTextField: UITextField, UITextFieldDelegate {
    
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
        
        self.keyboardType = .decimalPad
        
        self.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        return false
        
    }
    
    @objc func textFieldDidChange() {
        
        if self.text!.components(separatedBy: ".").count > 2 {
            
            self.text = self.text!.components(separatedBy: ".")[0] + "." + self.text!.components(separatedBy: ".")[1]
            
        } else {
            
            if self.text! == "." {
                
                self.text = "0."
                
            } else {
                
                if let num = Double(self.text!.replace(target: ",", withString: "")) {
                    
                    if self.text!.contains(".") {
                        
                        if self.text!.components(separatedBy: ".")[1].count > 2 {
                            
                            self.text = (Double(Int(num * 100.0))/100.0).addCommas(Decimal: 2)
                            
                        }
                        
                    } else {
                        
                        self.text = num.addCommas(Decimal: 0)
                        
                    }
                    
                }
                
            }
            
        }
        
        self.on_textFieldEditingChanged()
        
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.on_textFieldShouldReturn()
        
        self.endEditing(true)
        
        return true
        
    }
    
    func getDoubleValue() -> Double {
        
        if let DoubleResult = Double(self.text!.replace(target: ",", withString: "")) {
            
            return DoubleResult
            
        } else {
            
            return 0.0
            
        }
        
    }
    
    func getStringValue() -> String {
        
        return self.text!.replace(target: ",", withString: "")
        
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text! != "" {
            
            if textField.text! == "0" || textField.text! == "0.00" {
                
                textField.text! = ""
                
            } else {
                
                if textField.text!.contains(".") {
                    
                    if let decimal = Int(textField.text!.components(separatedBy: ".")[1]) {
                        
                        if decimal == 0 {
                            
                            textField.text = textField.text!.components(separatedBy: ".")[0]
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text! != "" {
            
            if textField.text!.contains(".") {
                
                if textField.text!.components(separatedBy: ".")[1].count < 2 {
                    
                    textField.text = textField.text!.components(separatedBy: ".")[0] + "." + ("\(textField.text!.components(separatedBy: ".")[1].characterAtIndex(index: 0) ?? "0")") + ("\(textField.text!.components(separatedBy: ".")[1].characterAtIndex(index: 1) ?? "0")")
                    
                }
                
            } else {
                
                textField.text = textField.text!.components(separatedBy: ".")[0] + ".00"
                
            }
            
        } else {
            
            textField.text = "0.00"
            
        }
        
    }
    
}

