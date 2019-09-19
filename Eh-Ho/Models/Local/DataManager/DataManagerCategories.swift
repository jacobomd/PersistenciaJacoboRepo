//
//  DataManagerCategories.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 17/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol DatabaseCategoriesDelegate {
    func initDefaultData()
    func deleteAllData()
    //func deleteTaskBy(id: Int) -> Bool
    func save(category: [Category])
    //func update(task: CategoryData) -> Bool
    func data() -> Array<CategoryData>
    //func findTaskBy(id: Int) -> CategoryData?
    //func findTasksBy(state: TaskState) -> Array<TaskData>
}

class DataManagerCategories {
    private var mDatabaseProvider: DatabaseCategoriesDelegate?
    //private var mUserPreferences: UserDefaultsPreferences?
    
    init() {
        mDatabaseProvider = DatabaseCoreDataCategories()
        //mUserPreferences = UserDefaultsPreferences()
    }
    
    deinit {
        mDatabaseProvider = nil
        //mUserPreferences = nil
    }
}


// User preferences methods
//extension DataManager {
//    func saveTask(stateSelected: TaskState) {
//        mUserPreferences?.saveTask(state: stateSelected.value)
//    }
//
//    func taskStateSelected() -> TaskState? {
//        guard let taskState = mUserPreferences?.taskState() else {
//            return nil
//        }
//
//        return TaskState(rawValue: taskState)
//    }
//
//    func deleteTaskStateSelected() {
//        mUserPreferences?.deleteTaskStateSelected()
//    }
//}


// Database Core Data methods
extension DataManagerCategories {
    func save(category: [Category]) {
         mDatabaseProvider?.save(category: category) 
    }
    
//    func update(task: CategoryData) -> Bool  {
//        return mDatabaseProvider?.update(task: task) ?? false
//    }
//
    func loadTasks() -> Array<CategoryData> {
        return mDatabaseProvider?.data() ?? Array()
    }
//
//    func loadTasks(by state: TaskState) -> Array<TaskData> {
//        return mDatabaseProvider?.findTasksBy(state: state) ?? Array()
//    }
    
//    func delete(task: CategoryData) -> Bool {
//        return mDatabaseProvider?.deleteTaskBy(id: task.id) ?? false
//    }
    
    func deleteAllTasks() {
        mDatabaseProvider?.deleteAllData()
    }
}
