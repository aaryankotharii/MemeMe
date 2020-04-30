//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by Aaryan Kothari on 30/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCollectionCell"

class SentMemesCollectionVC: UICollectionViewController {
    
    var memes : [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    private let spacing: CGFloat = 3        /// Inter cell space
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView.collectionViewLayout.invalidateLayout()
//    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
      //  return memes.count
        
        return 10
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemesCollectionViewCell
    
//        let meme = memes[indexPath.item]
//
//        if let memeImage = meme.memeImage {
//            cell.memeImageView.image = memeImage
//        }
        return cell
    }
}


//MARK:-  CollectionView FlowLayout Delegate methods
extension SentMemesCollectionVC : UICollectionViewDelegateFlowLayout{
    
    //MARK:- 3 cells for potrait and 5 for landscape
    private var numberOfCellsPerRow: Int {
        return UIDevice.current.orientation.isPortrait ? 3 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero           /// zero inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    //MARK: Size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - CGFloat(numberOfCellsPerRow - 1) * spacing
        let cellWidth = availableWidth / CGFloat(numberOfCellsPerRow)
        return .init(width: cellWidth, height: cellWidth)
    }

    // invalidate layout
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
