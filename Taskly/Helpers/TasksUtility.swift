//
//  TasksUtility.swift
//  Taskly
//
//  Created by Вовк Ольга' on 2/19/19.
//  Copyright © 2019 Вовк Ольга'. All rights reserved.
//

import Foundation

class TasksUtility {
    
    private static let key = "tasks"
    
    //archive
    private static func archive( tasks: [[Task]]) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: tasks) as NSData
    }
    //fetch
    
    static func fetch() -> [[Task]]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else {return nil}
        
        return (NSKeyedUnarchiver.unarchiveObject(with: unarchivedData) as? [[Task]])
    }
    
    //save
    static func save( tasks: [[Task]]) {
        
        //archive
        
        let archivedTasks = archive(tasks: tasks)
        
        //set object for key
        UserDefaults.standard.set(archivedTasks, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
