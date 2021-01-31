//
//  NNFW_UIButton.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

class NNBackButton: UIButton {
    
    override func willMove(toWindow newWindow: UIWindow?) {
        
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
    }
    
    @objc func onClick() {
        
        self.parentViewController?.navigationController?.popViewController(animated: true)
        
    }
    
}

class NNBackToRootButton: UIButton {
    
    override func willMove(toWindow newWindow: UIWindow?) {
        
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
    }
    
    @objc func onClick() {
        
        self.parentViewController?.navigationController?.popToRootViewController(animated: true)
        
    }
    
}

class NNCloseButton: UIButton {
    
    override func willMove(toWindow newWindow: UIWindow?) {
        
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
    }
    
    @objc func onClick() {
        
        self.parentViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}
