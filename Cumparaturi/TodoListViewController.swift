//
//  ViewController.swift
//  Cumparaturi
//
//  Created by Bogdan Stratulat on 04/01/2019.
//  Copyright © 2019 Bogdan Stratulat. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

   var itemArray = ["Cumpara fasole", "Cumpara Cartofi", "Cumpara ceapa"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = itemArray [indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Add new items\\
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFiel = UITextField()
        
        let alert = UIAlertController(title: "Adauga", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Adauga produs", style: .default) { (action) in
            //what happens
            self.itemArray.append(textFiel.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textFiel = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
}
}

