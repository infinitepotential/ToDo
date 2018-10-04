//
//  ViewController.swift
//  ToDo
//
//  Created by Catherine Chan on 4/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController, UITextFieldDelegate {

    
    var itemArray = ["Buy Eggs", "Buy Avocado", "Read Books"]
    
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
    
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // would like to see a pop up or an UI Alert Controller to show when I press the add button, a text field in that UI Alert so that I can  Write a quick to do list item and Append it into my Item Array
        
        var textField = UITextField() // This text field has the entire scope of the addButtonPressed method.
        
        let alert = UIAlertController(title: "Add New To Do List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (Action) in
             // What will happen once the user clincks the add Button on our UIAlert
            print(textField.text!)
            self.itemArray.append(textField.text!) // It is safe to use !The textField.text is always not going to be nil. worst is empty ""
            
            self.tableView.reloadData() // have to refresh data to get the data showed up
        }
        
        
        alert.addTextField { (alertTextField) in // we are going to call the textfield created called alertTextField
            alertTextField.placeholder = "Create New Item"
            //This is the string that is going to be showed in Grey and disppear when the User click on the text field
        
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

