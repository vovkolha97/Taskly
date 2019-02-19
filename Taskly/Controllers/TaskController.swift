//
//  TaskController.swift
//  Taskly
//
//  Created by Вовк Ольга' on 2/8/19.
//  Copyright © 2019 Вовк Ольга'. All rights reserved.
//

import UIKit

class TaskController: UITableViewController {
    
    var taskStore: TaskStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    @IBAction func addTask2(_ sender: UIBarButtonItem) {
        print("Add task")
        
        //Setting up alert controller
        
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        //Set up the actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            
            //grab text field text
            guard let name = alertController.textFields?.first?.text else { return }
            //create task
            let newTask = Task(name: name)
            //add task
            self.taskStore.add(task: newTask, at: 0)
            //reload table in tableView
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        addAction.isEnabled = false
        
        let cancelActon = UIAlertAction(title: "Cancel", style: .cancel)
        // Add the text field
        alertController.addTextField { textField in
            
            textField.placeholder = "Enter task name..."
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
        // Add the actions
        alertController.addAction(addAction)
        alertController.addAction(cancelActon)
        //Present
        present(alertController, animated: true)
    }
   /*
    @IBAction func addTask(_ sender: UIBarButtonItem) {
 
 
    }
 */
    @objc private func handleTextChanged( sender: UITextField){
        //Grab the allert controller and add action
        guard let alertController = presentedViewController as? UIAlertController,
        let addAction = alertController.actions.first,
        let text = sender.text
            else{ return }
        
        //enable add action based on if text is empty or contains whitespace
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
        
    }
}

// MARK: - DataSource
extension TaskController {
    
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    return section == 0 ? "To-do" : "Done"
    
    }
    
   override func numberOfSections(in tableView: UITableView) -> Int {
        return taskStore.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.tasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = taskStore.tasks[indexPath.section][indexPath.row].name
        return cell
    }
}
//MARK: - Delegate
extension TaskController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
          
            //determine whether the task 'is done'
            guard let isDone = self.taskStore.tasks[indexPath.section][indexPath.row].isDone else { return }
            //remove the task from apropriate array
            self.taskStore.removeTask(at: indexPath.row, isDone: isDone)
            
            //reload tableView
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //indicate that the action ws preformed
            
            completionHandler(true)
            
        }
        
       deleteAction.image = #imageLiteral(resourceName: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.1450980392, blue: 0.168627451, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in

            //toggle that the task is done
            self.taskStore.tasks[0][indexPath.row].isDone = true
            //remove the task from the array containing todo tasks
            let doneTask = self.taskStore.removeTask(at: indexPath.row)
            
            //reload the tableview
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //add he task to the array containing done tasks
            self.taskStore.add(task: doneTask, at: 0, isDone: true)
            //reload table view
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            //indicate that the action was preformed
        completionHandler(true)
        
        }
        
        doneAction.image = #imageLiteral(resourceName: "done")
        doneAction.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.7529411765, blue: 0.2901960784, alpha: 1)
        
        
        
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [doneAction]) : nil
    }
 
}
