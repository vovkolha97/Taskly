//
//  task.swift
//  Taskly
//
//  Created by Вовк Ольга' on 2/11/19.
//  Copyright © 2019 Вовк Ольга'. All rights reserved.
//

import Foundation


class Task {
    
    var name: String
    var isDone: Bool
    
    init(name: String, isDone: Bool = false) {
        self.name = name
        self.isDone = isDone
    }
}
