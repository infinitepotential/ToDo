//
//  ViewController.swift
//  ToDo
//
//  Created by Catherine Chan on 4/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController, UITextFieldDelegate {

    var itemArray = [Items]() // instead of hard coding the array, make the array consist of Item object
    //Option 1 to store the todoList data
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") // add a path compotent
    
    // FileManager is an objet that provides an interfact to the file system. defaul is the shared object (singleton), we are looking for documents directory inside the userDomainMask - user's home directory, any personal items saved in this current app
    // This need to be a global constant to be accessible to all methods within the class
    



    
//option 2 to save data in userDefault
//    let defaults = UserDefaults.standard // this is an interface to user's default database where you store your key value pairs persistently across launch your app. This cause app crash because the data cannot be retrieve by Swift, you are not mean to save the data structure file there.
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            print(dataFilePath)
        
//        let newItem = Items() // newItem is an object of class Items
//        newItem.title = "Buy Eggs"
//        itemArray.append(newItem)
//
//        let newItem2 = Items()
//        newItem2.title = "Buy Avocada"
//        itemArray.append(newItem2)
//
//        let newItem3 = Items()
//        newItem3.title = "Go YumCha"
//        itemArray.append(newItem3)
//  Since we have already saved these items into our p-list, we can delete these for now.
        
        loadItems()
        
//         Do any additional setup after loading the view, typically from a nib.
//        if let item = defaults.array(forKey: "TodoListArray") as? [Items] {
//            itemArray = item
//        }
       
        
    }
  
    //MARK: Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
     //TODO: Declare cellForRowAtIndexPath here:
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // since we are using the original IOS cell, I don't need customisation
        
        // This  "cellForRowAt indexPath:" method get called when the table view gets called initially and loaded up, and at that time point, none of our items are done, and none of them get accessory mark
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell"), If we use this method, each time the cell off the screen, it will get relocated to other cell, the checkmark we ticked will be gone.
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ToDoItemCell", for: indexPath) // The idenfier is the identifier we gave to our prototype cell. However, by using this property, if the checked cell off the screen, and we keep scrolling down, the cell got re-located to another cell, it got checked as well even without us checking it. so to solve this issue we can create a model. 
        
//        cell.textLabel?.text = itemArray[indexPath.row] // this need to be replaced because this is going to return an item object, we actuall  need to tap into the class title property.
        
        let item =  itemArray[indexPath.row]
        
         cell.textLabel?.text = item.title
        
        // ternery operator == >
        // value = condition ? valueIfTrue : valueIfFalse
        // option 1
        cell.accessoryType = item.done ? .checkmark : .none
        
        //Option 2
        //   if item.done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }

        
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
    // so the cell in this indexPath is going to have an accessory type of checkmark when selected. (checkmark is not delected yet)
       
        //option 1 more succinct, this set the done property of the existing array to the opposite
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
     
         // Option 2
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done =  true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        self.saveItems()
        
        
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else {
//             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        
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
            
            let newItem = Items()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
//            self.itemArray.append(textField.text!) // It is safe to use !The textField.text is always not going to be nil. worst is empty ""
            
            self.saveItems()
        }
        
        
        alert.addTextField { (alertTextField) in // we are going to call the textfield created called alertTextField
            alertTextField.placeholder = "Create New Item"
            //This is the string that is going to be showed in Grey and disppear when the User click on the text field
        
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Method
    
    func saveItems() {
        //Option 1
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray) // This will encode our item list into a p-list, value we are going to encode is our itemArray. (if it is in a closure, mark all property with a self) not in this case.
            
            try data.write(to:dataFilePath!) // after encoding the data, write the data to the p-list
        }
        catch {
            print("Error encoding item array, \(error)")
        }
        
        // Option obselete: self.defaults.set(self.itemArray, forKey: "TodoListArray")// you need to have the key to retrieve the value, the value added can be any data type, Array, dictionary or String etc.  And this got saved in a P-list file. This will not work when I change to use the data struture in the model
        
        
        
        self.tableView.reloadData() //  this will reflect the change when we select/deselect the item. This force the table view to call its data source methods again, so will reload the data
    }
    
    func loadItems () {
         // because the method will throw error, so we use try? which will turn this method into an optional. We also use an optional binding to make it unwrap safely.
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder ()
            do {
            itemArray = try decoder.decode([Items].self, from: data)
            }
            catch {
                print("There is error: \(error)")
            }
        } // we are not specifying the the object Items() becasue we are refering to the dataType
       
    
}

}
