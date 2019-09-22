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
    func saveCategories(category: [Category])
    func dataCategories() -> Array<CategoryData>
    
}

protocol DatabaseTopicsDelegate {
    func initDefaultDataTopics()
    func deleteAllDataTopics()
    func saveTopics(topic: [Topic])
    func dataTopics(id: Int) -> Array<TopicData>

}

protocol DatabasePostsDelegate {
    func initDefaultDataPosts()
    func deleteAllDataPosts()
    func savePosts(post: [Post2])
    func updatePosts(post: [Post2])
    func dataPosts(id: Int) -> Array<PostData>

}

protocol DatabaseUsersDelegate {
    func initDefaultDataUsers()
    func deleteAllDataUsers()
    func saveUsers(user: [User4])
    func updateUsers(user: [User4])
    func dataUsers() -> Array<UserData>
 
}

class DataManager {
    private var mDatabaseProviderCategories: DatabaseCategoriesDelegate?
    private var mDatabaseProviderTopics: DatabaseTopicsDelegate?
    private var mDatabaseProviderPosts: DatabasePostsDelegate?
    private var mDatabaseProviderUsers: DatabaseUsersDelegate?


    private var mUserPreferences: UserDefaultsPreferences?
    
    init() {
        mDatabaseProviderCategories = DatabaseCoreData()
        mDatabaseProviderTopics = DatabaseCoreData()
        mDatabaseProviderPosts = DatabaseCoreData()
        mDatabaseProviderUsers = DatabaseCoreData()



        mUserPreferences = UserDefaultsPreferences()
    }
    
    deinit {
        mDatabaseProviderCategories = nil
        mDatabaseProviderTopics = nil
        mDatabaseProviderPosts = nil
        mDatabaseProviderUsers = nil

        mUserPreferences = nil
    }
}


 //User preferences methods
extension DataManager {
    func saveLastDownload() {
        mUserPreferences?.saveLastDownload()
    }

    func loadLastDownload() -> Date? {
        guard let dateLastDownload = mUserPreferences?.loadLastDownload() else {
            return nil
        }

        return dateLastDownload
    }
}


// Database Core Data methods Category
extension DataManager {
    func saveCategories(category: [Category]) {
         mDatabaseProviderCategories?.saveCategories(category: category)
    }
    

    func dataCategories() -> Array<CategoryData> {
        return mDatabaseProviderCategories?.dataCategories() ?? Array()
    }

    func deleteAllCategories() {
        mDatabaseProviderCategories?.deleteAllDataCategories()
    }
}

// Database Core Data methods Topic
extension DataManager {
    func saveTopics(topic: [Topic]) {
        mDatabaseProviderTopics?.saveTopics(topic: topic)
    }
    
    
    func dataTopics(id: Int) -> Array<TopicData> {
        return mDatabaseProviderTopics?.dataTopics(id: id) ?? Array()
    }
 
    
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
    
    func dataPosts(id: Int) -> Array<PostData> {
        return mDatabaseProviderPosts?.dataPosts(id: id) ?? Array()
    }
    
    func deleteAllPosts() {
        mDatabaseProviderPosts?.deleteAllDataPosts()
    }
}

extension DataManager {
    func saveUsers(user: [User4]) {
        mDatabaseProviderUsers?.saveUsers(user: user)
    }
    
    func updateUsers(user: [User4])   {
        mDatabaseProviderUsers?.updateUsers(user: user)
    }
    
    func dataUsers() -> Array<UserData> {
        return mDatabaseProviderUsers?.dataUsers() ?? Array()
        
    }
 
    func deleteAllUsers() {
        mDatabaseProviderUsers?.deleteAllDataUsers()
    }
}
