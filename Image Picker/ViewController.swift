//
//  ViewController.swift
//  Image Picker
//
//  Created by Arturo Reyes on 2/24/17.
//  Copyright © 2017 Arturo Reyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
  
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    let memeTextAttributes:[String:Any] = [
    NSStrokeColorAttributeName: UIColor.black, NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: -3.0]
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else {
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        
        
        self.topTextField.text = "TOP"
        self.bottomTextField.text = "BOTTOM"
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.topTextField.textAlignment = NSTextAlignment.center
        self.bottomTextField.textAlignment = NSTextAlignment.center
    }
    
    @IBAction func pickImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            if textField == self.topTextField {
                self.topTextField.text = "TOP"
            } else if textField == self.bottomTextField {
                self.bottomTextField.text = "BOTTOM"
            }
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
        

}

