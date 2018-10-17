//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Catherine Chan on 9/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController, UITextFieldDelegate {
     var categoryArray = [Category]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

     loadCategory()
   
    }

     //MARK: - TableView Datasource Methods
    
     //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categoryArray.count
       
    }
    
  
    
     //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        //shorten the codes by  cell.textLabel?.text = categoryArray[indexPath.row].name
        
        print("Declare cellForRowAtIndexPath is successful")
        
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
            destinationVC.selectedCategory = categoryArray[indextPath.row]
        }
        
    }
    
     //MARK: - Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

       
        var textField = UITextField()


        let alert = UIAlertController (title: "Add New Category in ToDo List", message: "", preferredStyle: .alert)


        let action = UIAlertAction(title: "Add Category", style: .default ) { (Action) in
            //You can highlight the "handler" under the UIAlertAction parameter and hit enter, and Xcode will generate the codes for us
            
        
            print (textField.text!)

            let newCategory = Category(context: self.context )

            newCategory.name = textField.text!

            self.categoryArray.append(newCategory)

            self.saveCategory()
        }
        
       

        alert.addTextField{ (alertTextField) in

            alertTextField.placeholder = "Create New Category"

            textField = alertTextField

            }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }
    
    
      //MARK: - Data Manipulation Method
    
    func saveCategory () {
        
        do {
            try context.save()
        }
        catch {
            print("error saving category \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
             categoryArray = try context.fetch(request)
             self.tableView.reloadData()
             print(categoryArray)
        }
        catch {
            print("Error Loading Category from context: \(error)")
        }
       
    }
    
   

    
   
    
    
}
