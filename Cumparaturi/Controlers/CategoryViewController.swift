//
//  CategoryViewController.swift
//  Cumparaturi
//
//  Created by Bogdan Stratulat on 06/01/2019.
//  Copyright © 2019 Bogdan Stratulat. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          loadCategories()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "NICI O CATEGORIE ADAUGATA"
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToProducts", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)}
            }
            catch {
                print("Fatal error \(error)")
            }
        tableView.reloadData()
        }
    
    
    func loadCategories() {
         categories = realm.objects(Category.self)
        tableView.reloadData()
        }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Adauga Categorie", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Adauga", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
             
            self.save(category: newCategory)

        }
     
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
        textField = field
        textField.placeholder = "Adauga o noua categorie"
        }
        present(alert, animated: true, completion: nil)
    
    }
    
    // Table view methods
    
    //  Tableview delegate methods
    
    // Data manipulation methods
    
}
