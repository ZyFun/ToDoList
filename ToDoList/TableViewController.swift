//
//  TableViewController.swift
//  ToDoList
//
//  Created by Дмитрий Данилин on 04.08.2020.
//  Copyright © 2020 Дмитрий Данилин. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        
        // Создаёи алерт контроллер и конфигурируем его
        let alertController = UIAlertController(title: "Новая запись", message: "Введите свою запись", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style:  .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                // Сохраняем новое задание на первую позицию
                self.saveTask(withTitle: newTaskTitle)
                // Перегружаем табличку для отображения новых данныхё
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        
        let cancelAction = UIAlertAction(title: "Выйти", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveTask(withTitle title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        
        let taskObgect = Task(entity: entity, insertInto: context)
        taskObgect.title = title
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title

        return cell
    }
}
