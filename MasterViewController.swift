//
//  MasterViewController.swift
//  FinalProject_NoteList
//
//  Created by Zach McDermott on 6/15/17.
//  Copyright © 2017 Zach McDermott. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, UISplitViewControllerDelegate {
    
    struct Storyboard {
        static let mainStoryboard = "Main"
        static let addNoteViewController = "AddNoteViewController"
    }

    var items = [Notes]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.tableFooterView = UIView()
        automaticallyAdjustsScrollViewInsets = true
        
        items = CoreDataHelper.retrieveNotes()

    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteListTableViewCell
        let row = indexPath.row
        let item = items[row]

        cell.noteTitleLabel.text = item.title

        return cell
    }
    

 
    // MARK: - Table view Editing
 
    // Override to support editing the table view.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            CoreDataHelper.delete(note: items[indexPath.row])
            items = CoreDataHelper.retrieveNotes()

        }
    }

    
    // Editing Mode
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated:  animated)
        
        if editing {
            tableView.setEditing(true, animated: true)
        } else {
            tableView.setEditing(false, animated: true)
            
        }
    }
    
    // Reorder table cells
    
    func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(item, at: destinationIndexPath.row)
        
        self.items = CoreDataHelper.retrieveNotes()

    }
    
    // MARK: - Navigation
    
    //Tapping tableView cell, sends note at cell indexPath to Detail View Controller for display

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
        
        if identifier == "displayNotes" {
            print("Table view cell tapped")
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let item = items[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.items = item

                }
            }
        }
    }
    
    // Unwind from Detail View Controller,
    // Unwind from Add Note View Controller
    
    @IBAction func unwindToMasterViewController(_ segue: UIStoryboardSegue) {
        self.items = CoreDataHelper.retrieveNotes()
    }
}


    // MARK: - Extension for Popover, AddNoteViewController

extension MasterViewController: UIPopoverPresentationControllerDelegate {
    
    // Add Note ViewController
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = UIStoryboard(name: Storyboard.mainStoryboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Storyboard.addNoteViewController)
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
}

