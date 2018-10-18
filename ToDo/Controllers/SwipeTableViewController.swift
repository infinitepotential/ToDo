//
//  SwipeTableViewController.swift
//  ToDo
//
//  Created by Catherine Chan on 19/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }
    
    //TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier:  "Cell", for: indexPath) as! SwipeTableViewCell
        
         cell.delegate = self
        
         return cell
    }
    
   
    //responsible what happen when user swipe the cell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        //the orientation for the swipe is from the right
        guard orientation == .right else { return nil }
        
        //handle what happen when swipe
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("Item Deleted")
            
            self.updateModel(at: indexPath)
//            if let categoryForDelection = self.categories?[indexPath.row] {
//                do {
//                    try self.realm.write {
//                        self.realm.delete(categoryForDelection)
//                    }
//                }
//                catch {
//                    print("Error deleting Category:\(error)")
//                }
//                //                tableView.reloadData()
//            }
            
        }
        // customize the action appearance: add an image to that part of the cell that is going to show
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //        options.transitionStyle = .border
        return options
    }
    
    func updateModel (at indexPath: IndexPath) {
        //update our data model
    }
    
    
}

