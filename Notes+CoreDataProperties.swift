//
//  Notes+CoreDataProperties.swift
//  FinalProject_NoteList
//
//  Created by Zach McDermott on 6/21/17.
//  Copyright © 2017 Zach McDermott. All rights reserved.
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?

}
