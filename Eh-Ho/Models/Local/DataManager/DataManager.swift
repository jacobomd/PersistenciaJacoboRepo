//
//  DataManager.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 17/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

protocol DatabaseCategoriesDelegate {
    func initDefaultDataCategories()
    func deleteAllDataCategories()
    //func deleteTaskBy(id: Int) -> Bool
    func saveCategories(category: [Category])
    func updateCategories(category: [Category])
    //func dataCategories() -> Array<Category>
    //func findTaskBy(id: Int) -> CategoryData?
    //func findTasksBy(state: TaskState) -> Array<TaskData>
}

protocol DatabaseTopicsDelegate {
    func initDefaultDataTopics()
    func deleteAllDataTopics()
    //func deleteTaskBy(id: Int) -> Bool
    func saveTopics(topic: [Topic])
    func updateTopics(topic: [Topic])
    //func dataTopics() -> Array<Topic>
    //func findTaskBy(id: Int) -> CategoryData?
    //func findTasksBy(state: TaskState) -> Array<TaskData>
}

protocol DatabasePostsDelegate {
    func initDefaultDataPosts()
    func deleteAllDataPosts()
    //func deleteTaskBy(id: Int) -> Bool
    func savePosts(post: [Post2])
    func updatePosts(post: [Post2])
    //func dataTPosts() -> Array<Topic>
    //func findTaskBy(id: Int) -> CategoryData?
    //func findTasksBy(state: TaskState) -> Array<TaskData>
}

class DataManager {
    private var mDatabaseProviderCategories: DatabaseCategoriesDelegate?
    private var mDatabaseProviderTopics: DatabaseTopicsDelegate?
    private var mDatabaseProviderPosts: DatabasePostsDelegate?

    //private var mUserPreferences: UserDefaultsPreferences?
    
    init() {
        mDatabaseProviderCategories = DatabaseCoreData()
        mDatabaseProviderTopics = DatabaseCoreData()
        mDatabaseProviderPosts = DatabaseCoreData()


        //mUserPreferences = UserDefaultsPreferences()
    }
    
    deinit {
        mDatabaseProviderCategories = nil
        mDatabaseProviderTopics = nil
        mDatabaseProviderPosts = nil

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


// Database Core Data methods Category
extension DataManager {
    func saveCategories(category: [Category]) {
         mDatabaseProviderCategories?.saveCategories(category: category)
    }
    
    func updateCategories(category: [Category])   {
         mDatabaseProviderCategories?.updateCategories(category: category)
    }

//    func loadTasksCategories() -> Array<CategoryData> {
//        return mDatabaseProviderCategories?.dataCategories() ?? Array()
//    }
//
//    func loadTasks(by state: TaskState) -> Array<TaskData> {
//        return mDatabaseProvider?.findTasksBy(state: state) ?? Array()
//    }
    
//    func delete(task: CategoryData) -> Bool {
//        return mDatabaseProvider?.deleteTaskBy(id: task.id) ?? false
//    }
    
    func deleteAllCategories() {
        mDatabaseProviderCategories?.deleteAllDataCategories()
    }
}

// Database Core Data methods Topic
extension DataManager {
    func saveTopics(topic: [Topic]) {
        mDatabaseProviderTopics?.saveTopics(topic: topic)
    }
    
    func updateTopics(topic: [Topic])   {
        mDatabaseProviderTopics?.updateTopics(topic: topic)
    }
    
//    func loadTasks() -> Array<Topic> {
//        return mDatabaseProviderTopics?.dataTopics() ?? Array()
//    }
    //
    //    func loadTasks(by state: TaskState) -> Array<TaskData> {
    //        return mDatabaseProvider?.findTasksBy(state: state) ?? Array()
    //    }
    
    //    func delete(task: CategoryData) -> Bool {
    //        return mDatabaseProvider?.deleteTaskBy(id: task.id) ?? false
    //    }
    
    func deleteAllTopics() {
        mDatabaseProviderTopics?.deleteAllDataTopics()
    }
}

extension DataManager {
    func savePosts(post: [Post2]) {
        mDatabaseProviderPosts?.savePosts(post: post)
    }
    
    func updatePosts(post: [Post2])   {
        mDatabaseProviderPosts?.updatePosts(post: post)
    }
    
    //    func loadTasks() -> Array<Topic> {
    //        return mDatabaseProviderTopics?.dataTopics() ?? Array()
    //    }
    //
    //    func loadTasks(by state: TaskState) -> Array<TaskData> {
    //        return mDatabaseProvider?.findTasksBy(state: state) ?? Array()
    //    }
    
    //    func delete(task: CategoryData) -> Bool {
    //        return mDatabaseProvider?.deleteTaskBy(id: task.id) ?? false
    //    }
    
    func deleteAllPosts() {
        mDatabaseProviderPosts?.deleteAllDataPosts()
    }
}
