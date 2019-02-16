//
//  taskStore.swift
//  Taskly
//
//  Created by Вовк Ольга' on 2/11/19.
//  Copyright © 2019 Вовк Ольга'. All rights reserved.
//

import Foundation

class TaskStore {
    
    var tasks = [[Task](), [Task]()]
    
    func add(task: Task, at index: Int, isDone: Bool = false){
        
        let section = isDone ? 1 : 0
        
        tasks[section].insert(task, at: index)
    }
    
  @discardableResult func removeTask(at index: Int, isDone: Bool = false) -> Task {
        
        let section = isDone ? 1 : 0

       return tasks[section].remove(at: index)
    }
    
}
