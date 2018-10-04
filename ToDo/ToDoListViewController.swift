//
//  ViewController.swift
//  ToDo
//
//  Created by Catherine Chan on 4/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController, UITextFieldDelegate {

    
    let itemArray = ["Buy Eggs", "Buy Avocado", "Read Books"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }
  
    //MARK: Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
     //TODO: Declare cellForRowAtIndexPath here:
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // since we are using the original IOS cell, I don't need customisation
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ToDoItemCell", for: indexPath) // The idenfier is the identifier we gave to our prototype cell
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK: Tableview Delegate Methods
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
//   toDoListView.addGestureRecognizer(tapGesture)
//
//    @objc func tableViewTapped () {
//        print("List is completed")
//    }
//
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row) // when we select the cell, print the number of the row in the console
//        print(itemArray[indexPath.row])
        
      // Grabing the reference of the selected cell
       
        // so the cell in this indexPath is going to have an accessory type of checkmark when selected. (checkmark is not delected yet
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
         tableView.deselectRow(at: indexPath, animated: true) // so that when we select the item, it will go grey, and then turn back to normal after the selection
    
      
    
    }
    
    
}

