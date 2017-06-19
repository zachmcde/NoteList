//
//  AddNoteViewController.swift
//  FinalProject_NoteList
//
//  Created by Zach McDermott on 6/15/17.
//  Copyright © 2017 Zach McDermott. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

//    struct Storyboard {
//        static let mainStoryboard = "Main"
//        static let newNoteViewController = "NewNoteViewController"
//    }
    
    var items: Item?
    
    @IBOutlet weak var newNoteTitleTextField: UITextField!
    @IBOutlet weak var newNoteContentTextView: UITextView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            newNoteTitleTextField.text = ""
            newNoteContentTextView.text = ""

    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let masterViewController = segue.destination as! MasterViewController
        
        if let identifier = segue.identifier {
            if identifier == "Save" {
                print("Save button tapped")
                
                    let newNote = Item()
                    newNote.title = newNoteTitleTextField.text ?? ""
                    newNote.content = newNoteContentTextView.text ?? ""
                    masterViewController.items.append(newNote)
                
            }
        }
    }
    

    
    // MARK: - Navigation

    
    // UIPopover Delegates
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(AddNoteViewController.dismissAddNoteViewController))
        navigationController.topViewController?.navigationItem.rightBarButtonItem = saveButton
        
        return navigationController
    }
    
    func dismissAddNoteViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Hide keyboard when user touches outside keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
