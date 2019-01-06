//
//  ViewController.swift
//  Cumparaturi
//
//  Created by Bogdan Stratulat on 04/01/2019.
//  Copyright © 2019 Bogdan Stratulat. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

   var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("produse.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
     loadItem()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = item.title
       
        cell.accessoryType = item.done ? .checkmark : .none
    
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //itemArray[indexPath.row].setValue("Completed", forKey: "titile")
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        saveItem()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Add new items\\
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFiel = UITextField()
        
        let alert = UIAlertController(title: "Adauga", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Adauga produs", style: .default) { (action) in
            //what happens
           
            let newItem = Item(context: self.context)
            newItem.title = textFiel.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItem()
     
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textFiel = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
}
    
    func saveItem() {
        do {
            try context.save()
        } catch {
            print("Error saving data \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItem() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
       itemArray = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
}

extension TodoListViewController: UISearchBarDelegate {
 

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        print("sucess")
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
}
