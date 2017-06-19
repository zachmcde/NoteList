//
//  MasterViewController.swift
//  FinalProject_NoteList
//
//  Created by Zach McDermott on 6/15/17.
//  Copyright © 2017 Zach McDermott. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    struct Storyboard {
        static let mainStoryboard = "Main"
        static let addNoteViewController = "AddNoteViewController"
    }

    var items = [Item]() {
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
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//
//        return true
//    }
 
    // Override to support editing the table view.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
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
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    
    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//
//        return true
//    }
    
    
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
}

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

    // Unwind from Detail View Controller,
    // Unwind from Add Note View Controller
    
    @IBAction func unwindToMasterViewController(_ segue: UIStoryboardSegue) {
        
    }
    
}
