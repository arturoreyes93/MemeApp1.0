//
//  ViewController.swift
//  Image Picker
//
//  Created by Arturo Reyes on 2/24/17.
//  Copyright © 2017 Arturo Reyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pickImage(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        self.present(pickerController, animated: true, completion: nil)
    }
    
    

}

