//
//  ViewMemeVC.swift
//  MemeMe
//
//  Created by Aaryan Kothari on 30/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ViewMemeVC: UIViewController {

    @IBOutlet var memeImageView: UIImageView!
    
    var meme : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memeImageView.image = meme
    }
}
