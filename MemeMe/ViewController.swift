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
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -5.0,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSetUp(bottomTextField)
        textFieldSetUp(topTextField)
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
       textfield.textAlignment = .center
       textfield.defaultTextAttributes = memeTextAttributes
    }
    
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
        return keyboardSize.cgRectValue.height
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
               // TODO: Save memed image
            activityViewController.dismiss(animated: true, completion: nil)
           }
        
    }
    
    
    
    func save() {
            // Create the meme
 
    }
    
    func generateMemedImage() -> UIImage {

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.ta

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
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled Image picker")
        picker.dismiss(animated: true, completion: nil)
    }
}

