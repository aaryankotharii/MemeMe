//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Aaryan Kothari on 30/04/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class SentMemesTableVC: UITableViewController {
    
    //MARK: Memes Array
    var memes : [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tomeme1"{
            let ViewMemeVC = segue.destination as! ViewMemeVC
            let meme = sender as! UIImage
            ViewMemeVC.meme = meme
        }
    }
}


// MARK:- TableView Datasource Methods
extension SentMemesTableVC {
    
    //Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableCell", for: indexPath) as! SentMemesTableViewCell
        
        let meme = memes[indexPath.row]
        
        //MARK: Cell Outlet values
        cell.memeImageView.image = meme.memeImage ?? UIImage(systemName: "questionmark")
        cell.memeTopLabel.text = meme.topText
        cell.memeBotttomLabel.text = meme.bottomText
        
        return cell
    }
    
    //MARK: conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


// MARK:- TableView Delegate Methods
extension SentMemesTableVC {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let meme = memes[indexPath.row]
        
        let image = meme.memeImage ?? UIImage(systemName: "questionmark")
        
        performSegue(withIdentifier: "tomeme1", sender: image)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat!
        
        if  UIDevice.current.orientation.isPortrait {
            height = self.view.frame.height / 6
        }
        else {
            height = self.view.frame.height / 3
        }
        return height
    }
    
    
    //MARK:- Delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete meme for og array
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}


