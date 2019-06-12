//
//  NNFWorkUIButton.swift
//  SuandokMeeting
//
//  Created by Saharat Sittipanya on 3/4/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

class NNBackButton: UIButton {
    
    override func willMove(toWindow newWindow: UIWindow?) {
        
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
    }
    
    @objc func onClick() {
        
        self.parentViewController?.navigationController?.popViewController(animated: true)
        
    }
    
}

class NNPickerButton: UIButton {
    
    let pickerView = NNPickerViewController()
    
    var onClickVerify: () -> Bool = { return true }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
    }
    
    @objc func onClick() {
        
        if self.onClickVerify() {
            self.parentViewController?.present(pickerView, animated: false, completion: nil)
        }
        
    }
    
    func setData(dataSource list: [[String]], _ didSelect: @escaping (Int, Int, String) -> Void) {
        
        self.pickerView.modalPresentationStyle = .overFullScreen
        
        self.pickerView.arrDataSource = list
        
        self.pickerView.NNPickerView_DidSelect = { (row, component, title) in
            
            didSelect(row, component, title)
            
        }
        
    }
    
}

class NNDatePickerButton: UIButton {
    
    let pickerView = NNDatePickerViewController()
    
    var didSelectDate: (String) -> Void = { (_) in }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        
        self.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        self.pickerView.didSelectDate = { (DATESTR) in
            
            self.didSelectDate(DATESTR)
            
        }
        
    }
    
    @objc func onClick() {
        
        self.pickerView.modalPresentationStyle = .overFullScreen
        self.parentViewController?.present(pickerView, animated: false, completion: nil)
        
    }
    
}
