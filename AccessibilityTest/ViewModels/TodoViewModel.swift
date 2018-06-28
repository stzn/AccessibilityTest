//
//  TodoViewModel.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/28.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

struct TodoViewModel {
    
    var homework: Homework
    
    init(homework: Homework) {
        self.homework = homework
    }
    
    func numberOfRows() -> Int {
        return homework.todos.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func itemFor(_ index: Int) -> Todo {
        return homework.todos[index]
    }
    
    mutating func selectItem(_ index: Int) {
        homework.todos[index].toggleIsCompleted()
    }
    
    func getState(_ index: Int) -> Bool {
        return homework.todos[index].isCompleted
    }
}
