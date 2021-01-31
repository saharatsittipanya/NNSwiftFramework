//
//  NNFW_ImagePicker.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

public class NNImagePickerViewController: UIViewController {
    
    weak var delegate: NNImagePickerViewControllerDelegate?
    
    var imagePicker: UIImagePickerController!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        
    }
    
    /// This function show PickerViewController
    /**
     เปิิด Dialog ถ่ายรูป, เลือกรูปขึ้นมา อย่าลืม self.delegate = self
     
     - Parameter isCameraOnly: Take photo on camera only. Defualt is false
     */
    public func pickerPhoto(_ isCameraOnly: Bool = false) {
        
        if isCameraOnly {
            
            self.imagePicker.sourceType = .camera
            
            self.present(self.imagePicker, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            alert.addAction(UIAlertAction(title: "CAMERA", style: .default, handler: { (action: UIAlertAction!) in
                
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }))
            alert.addAction(UIAlertAction(title: "PHOTO LIBRARY", style: .default, handler: { (action: UIAlertAction!) in
                
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }))
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}

@objc public protocol NNImagePickerViewControllerDelegate: class {
    
    /// This function call when crop image done
    /**
     จะได้รูปที่ Crop แล้วมา
     
     - Parameter image: Image is Croped.
     */
    @objc optional func NNImagePicker(didSelected image: UIImage)
    
    /// This function call when crop image cancel
    @objc optional func NNImagePickerDidCancel()
    
}

extension NNImagePickerViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.imagePicker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
        self.delegate?.NNImagePicker?(didSelected: selectedImage)
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.imagePicker.dismiss(animated: true, completion: nil)
        self.delegate?.NNImagePickerDidCancel?()
        
    }
    
}
