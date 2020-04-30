//
//  ViewMemeVC.swift
//  MemeMe
//
//  Created by Aaryan Kothari on 30/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ViewMemeVC: UIViewController {

    //MARK: Outlets
    @IBOutlet var memeImageView: UIImageView!
    
    var meme : UIImage!  /// MEME Image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memeImageView.image = meme
    }
}
