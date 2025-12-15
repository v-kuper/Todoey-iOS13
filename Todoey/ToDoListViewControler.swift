//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewControler: UITableViewController {
    
    // Сделали массив изменяемым
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Переключение чекмарк состояния
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item", message: nil, preferredStyle: .alert)
        
        // Переменная для ссылки на текстовое поле
        var inputTextField: UITextField?
        
        alert.addTextField { textField in
            textField.placeholder = "Create new item"
            inputTextField = textField
        }
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { [weak self] _ in
            guard let self = self else { return }
            // Безопасно достаем текст, убираем пробелы и проверяем на пустую строку
            let newTitle = inputTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            guard !newTitle.isEmpty else { return }
            
            self.itemArray.append(newTitle)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}
