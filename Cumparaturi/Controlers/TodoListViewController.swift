//
//  ViewController.swift
//  Cumparaturi
//
//  Created by Bogdan Stratulat on 04/01/2019.
//  Copyright © 2019 Bogdan Stratulat. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

   var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("produse.plist")

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
       
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
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
            let newItem = Item()
            newItem.title = textFiel.text!
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
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding")
        }
        self.tableView.reloadData()
    }
    
    func loadItem() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print ("Error")
            }
            }
    }
}

