//
//  DetailViewController.swift
//  FinalProject_NoteList
//
//  Created by Zach McDermott on 6/15/17.
//  Copyright © 2017 Zach McDermott. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var items: Notes?

    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let item = items {
          
            noteTitleTextField.text = item.title
            noteContentTextView.text = item.content
            
        } else {
        
        noteTitleTextField.text = ""
        noteContentTextView.text = ""
        
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

        if let detailItem = self.items {
            navigationItem.title = detailItem.title
            noteTitleTextField.text = detailItem.content
        }
    }



    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let masterViewController = segue.destination as! MasterViewController
        
        if let identifier = segue.identifier {
            if identifier == "Done" {
                print("Done button tapped")
                
                if let note = items {
                
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                masterViewController.tableView.reloadData()
                    
                } else {
                    
                    let note = self.items ?? CoreDataHelper.newNote()
                    note.title = noteTitleTextField.text ?? ""
                    note.content = noteContentTextView.text ?? ""
                    CoreDataHelper.saveNote()
                    
                }
                
            }
        }
    }
 
    // Hide keyboard when user touches outside keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
