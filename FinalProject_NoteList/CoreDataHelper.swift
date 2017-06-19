//
//  CoreDataHelper.swift
//  FinalProject_NoteList
//
//  Created by Zach McDermott on 6/19/17.
//  Copyright © 2017 Zach McDermott. All rights reserved.
//

import CoreData
import UIKit



class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    var note = [NSManagedObject] ()
    
    static func newNote() -> Notes {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: managedContext) as! Notes
        return note
    }
    
    static func saveNote() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(note: Notes) {
        managedContext.delete(note)
        saveNote()
    }
    
    static func retrieveNotes() -> [Notes] {
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    
    static func updateNotes() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
}
