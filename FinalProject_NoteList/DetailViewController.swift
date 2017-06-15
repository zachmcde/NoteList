//
//  DetailViewController.swift
//  FinalProject_NoteList
//
//  Created by Zach McDermott on 6/15/17.
//  Copyright © 2017 Zach McDermott. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item: Item?
    

    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let items = item {
          
            noteTitleTextField.text = items.title
            noteContentTextView.text = items.text
            
        } else {
        
        noteTitleTextField.text = ""
        noteContentTextView.text = ""
        
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

//        if let detailItem = self.item {
//            navigationItem.title = detailItem.title
//            noteTitleTextField.text = detailItem.text
//        }
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindToDetailsViewController(_ segue: UIStoryboardSegue) {
        
    }
        
}
