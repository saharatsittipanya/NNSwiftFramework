//
//  NNPickerView.swift
//  4SCTF
//
//  Created by Saharat Sittipanya on 5/3/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import UIKit

class NNPickerView: UIView {

    weak var delegate: NNPickerViewDelegate?
    
    var pickerViewData: [[String]] = []
    
    @IBOutlet weak var pickerView: UIPickerView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    override func awakeFromNib() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.closeWithAnimate()
    }
    
    func closeWithAnimate(){
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.alpha = 0
        }, completion: { (finished: Bool) in
            self.removeFromSuperview()
        })
        
        self.delegate?.didClosePickerView?()
        
    }

}

@objc protocol NNPickerViewDelegate: class {
    
    @objc optional func didSelectPickerView(_ Str: String)
    @objc optional func didClosePickerView()
    
}

extension NNPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerViewData[component].count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerViewData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.delegate?.didSelectPickerView?(self.pickerViewData[component][row])
        self.closeWithAnimate()
    }
    
}
