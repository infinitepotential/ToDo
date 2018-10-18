//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Catherine Chan on 9/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import UIKit
import RealmSwift
//import CoreData
//import SwipeCellKit

class CategoryViewController: SwipeTableViewController, UITextFieldDelegate {
    
    //Option 3 CoreData
    //     var categoryArray = [Category]()
    //     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //Option 4: Realm
    let realm = try! Realm()
    var categories: Results<Category>? // Results is a realm dataType as result of the queries, this contain result of all the Category objects

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     loadCategory()
   
    }

     //MARK: - TableView Datasource Methods
    
     //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        //Option 3 CoreData
//        return categoryArray.count
        
        //Option4: Realm
        return categories?.count ?? 1 // This is call Nil Coalescing Operator: the front part could be nil, then return the later value 1
       
    }
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
    //        cell.delegate = self
    //        return cell
    //    }
    //
  
    
     //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Step 5: Not swipable
//          let cell = tableView.dequeueReusableCell(withIdentifier:  "CategoryCell", for: indexPath)
        
         // Step 6: SwipeCell in Category Controller
//        let cell = tableView.dequeueReusableCell(withIdentifier:  "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
//        cell.delegate = self 
        
        //Step 7: Separate SwipeCell Controller
        let cell = super.tableView(tableView, cellForRowAt: indexPath) // this will tap into the cell inside the super view, at our current index path
        
        
        //Option 3: CoreData
        // let category = categoryArray[indexPath.row]
        
        //Option4: Realm
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category added yet"
        
        //shorten the codes by  cell.textLabel?.text = categoryArray[indexPath.row].name
        
//        print("Declare cellForRowAtIndexPath is successful") // testing codes only
        
        return cell
    
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        // the current row that is seleted
        if let indextPath = tableView.indexPathForSelectedRow {
            //Option3: CoreData
//            destinationVC.selectedCategory = categoryArray[indextPath.row]
            
            //Option4: Realm
             destinationVC.selectedCategory = categories?[indextPath.row] // it can be an optional / Nil value for .selectedCategory
        }
        
    }
    
    //MARK: - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDelection = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDelection)
                }
            }
            catch {
                print("Error deleting Category:\(error)")
            }
//                         tableView.reloadData() // Angela's explanation is not clear, because swipe will try to delete the last row in the app, that is why we need to delete this line. It will cause error if I let it stay. 
                    }
    }
    
    
    
     //MARK: - Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

       
        var textField = UITextField()


        let alert = UIAlertController (title: "Add New Category in ToDo List", message: "", preferredStyle: .alert)


        let action = UIAlertAction(title: "Add Category", style: .default ) { (Action) in
            //You can highlight the "handler" under the UIAlertAction parameter and hit enter, and Xcode will generate the codes for us
            
        
            print (textField.text!)
            
        //Option 3 CoreData
        //            let newCategory = Category(context: self.context )
            
            //Option 4: Realm
            
            let newCategory = Category()

            newCategory.name = textField.text!
            
            //Option 1-3 Userdefaul - Plist - CoreData
            //   self.categoryArray.append(newCategory)
            //            self.saveCategory()
            
            
            //Option 4: Realm: We don't need to append the newCategory any more becasue categories is Result type which is auto-updated.
           
            
            
            //Option 4: Realm
            self.save(category: newCategory)
            
        }
        
       
        alert.addTextField{ (alertTextField) in

            alertTextField.placeholder = "Create New Category"

            textField = alertTextField

            }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }
    
    
      //MARK: - Data Manipulation Method
    //Option 1-3: Userdefault-Plist-Coredata
//    func saveCategory () {
    
    //Option 4: Realm
        func save(category : Category) {

        do {
            //Option 3: CoreData
            //            try context.save()
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("error saving category \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadCategory(){
    // Option 3 CoreData
    
// let request: NSFetchRequest<Category> = Category.fetchRequest()
//
//        do {
//             categoryArray = try context.fetch(request)
//        }
//        catch {
//            print("Error Loading Category from context: \(error)")
//        }
        
        //Option 4 Realm
        categories = realm.objects(Category.self) // This will pull out all the items inside our realm they are of Category Objects
 tableView.reloadData()
    }

}
