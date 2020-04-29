//
//  ViewController.swift
//  MemeMe
//
//  Created by Aaryan Kothari on 28/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet var imagePickerView: UIImageView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var shareButton: UIBarButtonItem!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var topBar: UIToolbar!
    @IBOutlet var bottomBar: UIToolbar!
    
    
    
    //MARK:- Constants
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -5.0,
    ]
    
    var memedImage : UIImage! /// FINAL MEME
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSetUp(bottomTextField)
        textFieldSetUp(topTextField)
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    private func textFieldSetUp(_ textfield : UITextField){
       textfield.delegate = memeTextFieldDelegate
        //textfield.textAlignment = .center
       textfield.defaultTextAttributes = memeTextAttributes
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: UIBarButtonItem) {
        presentImagePicker(.photoLibrary)
     }
    
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        presentImagePicker(.camera)
    }
    
    func presentImagePicker(_ source : UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = generateMemedImage()
           
           let shareItems = [memedImage]
           let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
           activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
           
        self.present(activityViewController, animated: true, completion: nil)
           
           activityViewController.completionWithItemsHandler = { activity, success, items, error in
           
            self.save()

            activityViewController.dismiss(animated: true, completion: nil)
            
           }
        
    }
    
    
    
    func save() {
            // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memeImage: memedImage)
        }
    
    func generateMemedImage() -> UIImage {
        
        bottomBar.isHidden = true
        topBar.isHidden = true

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        bottomBar.isHidden = false
        topBar.isHidden = false

        return memedImage
    }
    
}


//MARK:- PickerController Delegate Methods
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
                imagePickerView.image = image
            }
         self.dismiss(animated: true, completion: nil )
        shareButton.isEnabled = true  /// Now You Can Share Your Meme
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled Image picker")
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Keyboard show + hide functions
extension ViewController {
    
   func subscribeToKeyboardNotifications() {
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
   }

   func unsubscribeFromKeyboardNotifications() {
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
   }
   
   @objc func keyboardWillShow(_ notification:Notification) {
       view.frame.origin.y -= getKeyboardHeight(notification)
   }
   
   @objc func keyboardWillHide(_ notification:Notification) {
       view.frame.origin.y = 0
   }

   func getKeyboardHeight(_ notification:Notification) -> CGFloat {
       let userInfo = notification.userInfo
       let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
       let height = keyboardSize.cgRectValue.height // Height of Keyboard
       return height
   }
    
}

