//
//  AddNoteViewController.swift
//  FinalProject_NoteList
//
//  Created by Zach McDermott on 6/15/17.
//  Copyright © 2017 Zach McDermott. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
    
    var items: Notes?
    
    @IBOutlet weak var newNoteTitleTextField: UITextField!
    @IBOutlet weak var newNoteContentTextView: UITextView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            newNoteTitleTextField.text = ""
            newNoteContentTextView.text = ""

    }
    
    // MARK: - Navigation
    
    // Segue for save button. Saves new note data and passes it to MasterViewController tableView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let masterViewController = segue.destination as! MasterViewController
        
        if let identifier = segue.identifier {
            if identifier == "Save" {
                print("Save button tapped")
                
//                    let newNote = Notes()
//                    newNote.title = newNoteTitleTextField.text ?? ""
//                    newNote.content = newNoteContentTextView.text ?? ""
//                    masterViewController.items.append(newNote)
                
//                 Save New Note to Core Data
                        let note = self.items ?? CoreDataHelper.newNote()
                        note.title = newNoteTitleTextField.text ?? ""
                        note.content = newNoteContentTextView.text ?? ""
                        masterViewController.items.append(note)

                        CoreDataHelper.saveNote()

            }

        }
        

        
    }

    // Hide keyboard when user touches outside keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

