//
//  ViewController.swift
//  MemeMe
//
//  Created by Aaryan Kothari on 28/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imagePickerView: UIImageView!
    
    @IBOutlet var cameraButton: UIBarButtonItem!
    
    @IBOutlet var topTextField: UITextField!
    
    @IBOutlet var bottomTextField: UITextField!
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = memeTextFieldDelegate
        bottomTextField.delegate = memeTextFieldDelegate
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    
    @IBAction func pickAnImageFromAlbum(_ sender: UIBarButtonItem) {
         let imagePicker = UIImagePickerController()
         imagePicker.delegate = self
         imagePicker.sourceType = .photoLibrary
         present(imagePicker, animated: true, completion: nil)
     }
    
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let image = info[/* TODO: Dictionary Key Goes Here */] as? UIImage {
                imagePickerView.image = image
            }
    }
}

