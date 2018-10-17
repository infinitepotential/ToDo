//
//  ViewController.swift
//  ToDo
//
//  Created by Catherine Chan on 4/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import UIKit
import CoreData


class ToDoListViewController: UITableViewController, UITextFieldDelegate {
    
    //Option 3: CoreData
    var itemArray = [Items]() // instead of hard coding the array, make the array consist of Item object
    
    var selectedCategory : Category? {
        didSet{ // the keyword will trigger the codes to run as soon as the seletedCategory value is set. which is when the category is chosen in the CategoryViewController
            loadItem()
            print("selected Category :\(selectedCategory!)")
        }
    }// it is going to be nil until we set it using the segue
    
    //option 1 to save data in userDefault
    //    let defaults = UserDefaults.standard // this is an interface to user's default database where you store your key value pairs persistently across launch your app. This cause app crash because the data cannot be retrieve by Swift, you are not mean to save the data structure file there.
    
    //Option 2 saving data to our own customise P-list.  This is the directory where the p-list is saved.
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist") // add a path component
    
    // FileManager is an object that provides an interfact to the file system. default is the shared object (singleton), we are looking for documents directory inside the userDomainMask - user's home directory, any personal items saved in this current app
    
    ///Users/catherinechan/Library/Developer/CoreSimulator/Devices/F0EF6B1A-F30D-45D5-91A6-9178B7126CCF/data/Containers/Data/Application/8B506C16-A533-4C55-8BBC-91CD7F2A7EE7/Library/Application (this is where our coredata is stored)
    // This need to be a global constant to be accessible to all methods within the class
    
    
    //Option 3: CoreData
    // We cannot just do this to access to the context area:let context = AppDelegate.persistantContainer.viewContext, becaseu AppDelegate is a class, we need to access to the object of that class.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //UIApplication.shared is a singleton app instance, when our app is running live on user's Iphone, shared UIApplication will correspond to our live application object. delegate ppt is the delegate of this app object. Option + ? ->  see it is an Optional UIApplicationDelegate. We downcast it as AppDelegate.They both inherit from the same class -> UI Application Delegate, the downcast is valid.
    //we now have access to our AppDelegate object, and tap into its ppt persistentContainer.viewContext
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Option 1: user default method
        //         Do any additional setup after loading the view, typically from a nib.
        //        if let item = defaults.array(forKey: "TodoListArray") as? [Items] { // cast this as array of String
        //            itemArray = item
        //        }
        
        
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
        // searchBar.delegate = self
       
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ToDoItemCell", for: indexPath) // The identifier is the identifier we gave to our prototype cell. However, by using this property, if the checked cell off the screen, and we keep scrolling down, the cell got re-located to another cell, it got checked as well even without us checking it. so to solve this issue we can create a model. indexPath is the position of the cell in the table. 
        
//        cell.textLabel?.text = itemArray[indexPath.row] // this need to be replaced because this is going to return an item object, we actuall  need to tap into the class title property.
        
         let item =  itemArray[indexPath.row]
       
        //option 1 to save data in userDefault
        //   if item.done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        
        //Option 2 saving data to our own customise P-list
        // ternery operator == >
        // value = condition ? valueIfTrue : valueIfFalse
        
        // option 3 Core Data
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
       
        
        return cell
        
    }
    
    //MARK: - Tableview Delegate Methods
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
       
        //option 1 to save data in userDefault
        //        if itemArray[indexPath.row].done == false {
        //            itemArray[indexPath.row].done =  true
        //        } else {
        //            itemArray[indexPath.row].done = false
        //        }
        
         //Option 2: our own P-list method
        // more succinct, this set the done property of the existing array to the opposite. tick marked for completion
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // You can also itemArrray[indexPath.row].setValue("completed", forKey: "title"): change the title to completed for every completed task
        
        
        //Option 3, remove the item totally
//         context.delete(itemArray[indexPath.row]) // This is to remove the item from our coredata, the oreder is important
//
//        itemArray.remove(at: indexPath.row) // This is only removing the item from current itemArray, the tableView DataSource
       
        self.saveItem()
        
        
        
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
        
        let alert = UIAlertController(title: "Add New Item In ToDo List", message: "", preferredStyle: .alert) // alert is the presentation to the User, action is the actual operation after User enter data
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (Action) in
             // What will happen once the user clicks the add Button on our UIAlert
            
            print(textField.text!)
            
          
            let newItem = Items(context: self.context) // when we Initialise the Items(), we can specify the context where this item is going to exist. Use self. because it is inside a closure
            
            // the 2nd context refer to the constant context declared above
         
            newItem.title = textField.text!
            
            newItem.done = false
            
            newItem.parentCategory = self.selectedCategory // because we have already link database relationship, so the - parentCategory is also available as extention for newItem. Value for seleted category is set in CategoryViewController.
            
            self.itemArray.append(newItem)
//            self.itemArray.append(textField.text!) // It is safe to use !The textField.text is always not going to be nil. worst is empty ""
            
            self.saveItem()
        }
        
        // This method will show the User the empty input text field
        alert.addTextField { (alertTextField) in // we are going to call the textfield created "alertTextField". we initaible an object by using the .addTextField
            alertTextField.placeholder = "Create New Item" //The local variable (inside closure) "alertTextField" is given a value inside the closure.
            //This is the string that is going to be showed in Grey and disppear when the User click on the text field
        
            textField = alertTextField // assign the value of the local variable to "addButtonPressed" function variable. Link the alert object with the UI outlet.
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Method
    
    func saveItem() {
        //Option 1
//        let encoder = PropertyListEncoder()
//        do {
//            let data = try encoder.encode(itemArray) // This will encode our item list into a p-list, value we are going to encode is our itemArray. (if it is in a closure, mark all property with a self) not in this case.
//
//            try data.write(to:dataFilePath!) // after encoding the data, write the data to the p-list
//        }
//        catch {
//            print("Error encoding item array, \(error)")
//        }
        
        // Option 2 : self.defaults.set(self.itemArray, forKey: "TodoListArray")// you need to have the key to retrieve the value, the value added can be any data type, Array, dictionary or String etc.  And this got saved in a P-list file. This will not work when I change to use the data struture in the model

        //Option 3 Persistent Storage CoreData
        //Commit our context to the permanent storage inside lazy var the persistencContainer in AppDelegate. transfer the data from our staging area to our permanent storage
        do {
            try context.save() //look at the context temporary area
        }
        catch {
            print("Error saving context: \(error)")
        }
        
        
        self.tableView.reloadData() //  this will reflect the change when we select/deselect the item. This force the table view to call its data source methods again, so will reload the data
    }
    

    // refactor the codes, so it will take in parameter with - external, requeste - internal parameter, dataType is NSFetchRequest, and return an array of items. Items.fetchRequest() is the default request if nothing has been enter. 
    func loadItem (with request: NSFetchRequest<Items> = Items.fetchRequest(), predicate : NSPredicate? = nil) { // we can set the default value of the predicate nil, then we can call loadItems () without parameters because both parameters have default value fetch all items： Items.fetchRequest() in parentCategory.  since NSPredicate can be nil, set it as an optional - ?. We can treat predicate as an action 
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!) // predicate is filter, selecte items only match the criteria.
    
        if let additionalPredicate = predicate {//predicate can be nil, so use if let Optional binding. if predicate is not nil, then use both filters as request predicate, or else use only the categoryPredicate as filter
             request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
//        let compoundPredicate = NSCompoundPredicate (andPredicateWithSubpredicates: [categoryPredicate, predicate])
//        request.predicate = compoundPredicate
        
        
//  Option 1 &2   // because the method will throw error, so we use try? which will turn this method into an optional. We also use an optional binding to make it unwrap safely.
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder ()
//            do {
//            itemArray = try decoder.decode([Item].self, from: data)
//            }
//            catch {
//                print("There is error: \(error)")
//            }
//        } // we are not specifying the the object Items() becasue we are refering to the dataType
//
        
//Option 3 CoreData
//        let request : NSFetchRequest<Items> = Items.fetchRequest() // because we pass the request as the parameter, we don't need to use this
        //You have to specify the dataType <Items> and the entity - Items you request
        do {
        itemArray = try context.fetch(request)
            // the result is going to be an array of items that stored in our persistent container
        }
        catch {
        print ("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - Search Bar Method
// Instad of putting the delegate in the class, we can do it as extension, so easy for code management and debugs.
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
//       request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) // initialise the predicate using a format, we are going to look at the title attribute of the itemArray, we are going to check that it contains a value in the search bar. The contents of the search bar is going to substitute the %@. [cd] means not case or diacritic sensitive
        
        // This a predicate class : how data is filtered and fectched
        
   
        
         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
// it expect an array of sortDescriptors, just contain 1 is also OK.

        
// shrink the code by refactor the loadItem()
//        do {
//            itemArray = try context.fetch(request)
//            // the result is going to be an array of items that stored in our persistent container
//        }
//        catch {
//            print ("Error fetching data from context \(error)")
//        }
        
        loadItem(with: request, predicate: predicate)
    //  print(searchBar.text!)
    }// when the user click the search item, this will trigger the function and get the tableView reloaded
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //everytime I type something diff in the searchBar is going to trigger this method, from text -> No text, this was going to be triggered
        if searchBar.text?.count == 0 {
            // when the user delete the search, not when it is loaded 1st time on screen because at that time the text didn't change
            loadItem()
            DispatchQueue.main.async {
                //This is the manager assign diff projects into diff threads. ask the dispatchQueue to get the main thread, this is where you are going to update your Interface element.  and run the searchBar method on the main queue
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
}
