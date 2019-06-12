//
//  NNPickerViewController.swift
//  4SCTF
//
//  Created by Saharat Sittipanya on 30/4/2562 BE.
//  Copyright © 2562 Wolves Corporation. All rights reserved.
//

import UIKit

class NNPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var NNPickerView_DidSelect: (Int, Int, String) -> Void = { _,_,_  in }
    
    var arrDataSource: [[String]] = [] {
        
        didSet {
            
            if self.pickerView != nil {
            self.pickerView.reloadAllComponents()
            }
            
        }
        
    }
    
    @IBOutlet weak var pickerView: UIPickerView! {
        
        didSet {
            
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        alphaChange(with: self.view, to: 1.0, in: 0.3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return self.arrDataSource.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.arrDataSource[component].count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.arrDataSource[component][row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.NNPickerView_DidSelect(row, component, self.arrDataSource[component][row])
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
