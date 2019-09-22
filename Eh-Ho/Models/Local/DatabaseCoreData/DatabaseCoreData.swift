//
//  DatabaseCoreData.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 17/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit
import CoreData

class DatabaseCoreData {
    

    // MARK: Private methods
    private func managedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    

    private func someEntityExists(id: Int, idAtribute: String, entityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(idAtribute) = \(id)")
        
        var results: [NSManagedObject] = []
        
        do {
            results = try (managedObjectContext()?.fetch(fetchRequest))!
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    

    
    private func fetchDataRequest(context: NSManagedObjectContext, entity: String, predicate: String? = nil) -> [NSManagedObject]?  {
        // Create fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        if let predicateRequest = predicate, !predicateRequest.isEmpty {
            fetchRequest.predicate = NSPredicate(format: predicateRequest)
        }
        
        do {
            // Get data from dabase with fetchRequest
            return try context.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            print("Error al crear y ejecutar fetchRequest para la entity: \(entity)")
            return nil
        }
    }
    
    private func delete(data: [NSManagedObject], context: NSManagedObjectContext) -> Bool {
        do {
            // Delete each object
            data.forEach{ context.delete($0) }
            
            // Save all context change
            try context.save()
            return true
        } catch {
            print("Error al eliminar todos los datos")
            return false
        }
    }
    
}

// MARK: - Database Categories delegate extension

// MARK: Private properties categories
private let entity_nameCategory = "Categories"
private let entity_key_idCategory = "categoryId"
private let entity_key_nameCategory = "name"

extension DatabaseCoreData: DatabaseCategoriesDelegate {

    
    func initDefaultDataCategories() {
        deleteAllDataCategories()
    }
    
    func deleteAllDataCategories() {
        guard let context = managedObjectContext() ,
            let data = fetchDataRequest(context: context,
                                        entity: entity_nameCategory) else {
                                            return
        }
        
        _ = delete(data: data,
                   context: context)
    }
    
    
    func saveCategories(category: [Category])  {
        
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_nameCategory,
                                                    in: context) else {
                                                        return
                                                        
        }
        
        for dataCategory in category {
            
            
            if someEntityExists(id: dataCategory.id, idAtribute: entity_key_idCategory, entityName: entity_nameCategory) {
                print("Data is already present")
                return
            }
                //else create and save new user
            else {
                
                let taskObject = NSManagedObject(entity: entity,
                                                 insertInto: context)
                
                do {
                    
                    taskObject.setValue(dataCategory.id, forKey: entity_key_idCategory)
                    taskObject.setValue(dataCategory.name, forKey: entity_key_nameCategory)
                    
                    try context.save()
                    print("Aqu esta el valor nulooooooooooooooooooooooo")
                    
                } catch {
                    print("Error al guardar la task: \(dataCategory.name)")
                    
                }
                
            }
            
        }
        
    }
    
    func dataCategories() -> Array<CategoryData> {
        guard let context = managedObjectContext(),
            let data = fetchDataRequest(context: context,
                                        entity: entity_nameCategory) else {
                                            return Array()
        }
        
        return data.compactMap { categoryCD in
            guard let id = categoryCD.value(forKey: entity_key_idCategory) as? Int,
                let name = categoryCD.value(forKey: entity_key_nameCategory) as? String else {
                    return nil
            }
            
            return CategoryData(categoryId: id,
                                name: name)
        }
    }
    
}


// MARK: - Database Topics delegate extension

// MARK: Private properties Topics
private let entity_nameTopic = "Topics"
private let entity_key_idTopic = "topicId"
private let entity_key_titleTopic = "title"
private let entity_key_viewsTopic = "views"
private let entity_key_idCategoryInTopic = "categoryId"

extension DatabaseCoreData: DatabaseTopicsDelegate {

    func initDefaultDataTopics() {
        deleteAllDataTopics()
    }
    
    func deleteAllDataTopics() {
        guard let context = managedObjectContext() ,
            let data = fetchDataRequest(context: context,
                                        entity: entity_nameTopic) else {
                                            return
        }
        
        _ = delete(data: data,
                   context: context)
    }
    
    
    func saveTopics(topic: [Topic])  {
        
        // deleteAllDataTopics()
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_nameTopic,
                                                    in: context) else {
                                                        return
                                                        
        }
        
        for dataTopic in topic {
            
            if someEntityExists(id: dataTopic.id, idAtribute: entity_key_idTopic, entityName: entity_nameTopic) {
                print("Data is already present")
                return
            }
                //else create and save new user
            else {
                
                let taskObject = NSManagedObject(entity: entity,
                                                 insertInto: context)
                
                do {
                    
                    taskObject.setValue(dataTopic.id, forKey: entity_key_idTopic)
                    taskObject.setValue(dataTopic.title, forKey: entity_key_titleTopic)
                    taskObject.setValue(dataTopic.views, forKey: entity_key_viewsTopic)
                    taskObject.setValue(dataTopic.categoryID, forKey: entity_key_idCategoryInTopic)
                    
                    try context.save()
                    
                } catch {
                    print("Error al guardar el topic \(dataTopic.title)")
                    
                }
            }
            
        }
        
    }
    
    func dataTopics(id: Int) -> Array<TopicData> {
        guard let context = managedObjectContext(),
            let data = fetchDataRequest(context: context,
                                        entity: entity_nameTopic,
                                        predicate: "\(entity_key_idCategory) = \(id)") else {
                                            return Array()
        }
        
        return data.compactMap { categoryCD in
            guard let topicId = categoryCD.value(forKey: entity_key_idTopic) as? Int,
                let title = categoryCD.value(forKey: entity_key_titleTopic) as? String,
                let categoryId = categoryCD.value(forKey: entity_key_idCategoryInTopic) as? Int,
                let views = categoryCD.value(forKey: entity_key_viewsTopic) as? Int else {
                    return nil
            }
            
            return TopicData(topicId: topicId, title: title, categoryId: categoryId, views: views)
        }
    }
    
    func updateTopics(topic: [Topic])  {
        
        
        for dataTopic in topic {
            
            guard let context = managedObjectContext(),
                let data = fetchDataRequest(context: context,
                                            entity: entity_nameTopic,
                                            predicate: "\(entity_key_idTopic) = \(dataTopic.id)"),
                let dataToUpdate = data.first else {
                    return
            }
            
            
            do {
                
                dataToUpdate.setValue(dataTopic.id, forKey: entity_key_idTopic)
                dataToUpdate.setValue(dataTopic.title, forKey: entity_key_titleTopic)
                dataToUpdate.setValue(dataTopic.views, forKey: entity_key_viewsTopic)
                dataToUpdate.setValue(dataTopic.categoryID, forKey: entity_key_idCategory)
                
                try context.save()
                
            } catch {
                print("Error al guardar el topic \(dataTopic.title)")
                
            }
        }
    }

}


// MARK: - Database Posts delegate extension

// MARK: Private properties Posts
private let entity_namePost = "Posts"
private let entity_key_idPost = "postId"
private let entity_key_cookdedPost = "cooked"
private let entity_key_canEditPost = "canEdit"
private let entity_key_idTopicInPost = "topicId"

extension DatabaseCoreData: DatabasePostsDelegate {
    
    func initDefaultDataPosts() {
        deleteAllDataPosts()
    }
    
    func deleteAllDataPosts() {
        guard let context = managedObjectContext() ,
            let data = fetchDataRequest(context: context,
                                        entity: entity_namePost) else {
                                            return
        }
        
        _ = delete(data: data,
                   context: context)
    }
    
    
    func savePosts(post: [Post2])  {
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_namePost,
                                                    in: context) else {
                                                        return
                                                        
        }
        
        for dataPost in post {
            
            if someEntityExists(id: dataPost.id, idAtribute: entity_key_idPost, entityName: entity_namePost) {
                print("Data is already present")
                return
            }
                //else create and save new user
            else {
                
                let postObject = NSManagedObject(entity: entity,
                                                 insertInto: context)

                
                do {
                    
                    postObject.setValue(dataPost.id, forKey: entity_key_idPost)
                    postObject.setValue(dataPost.cooked, forKey: entity_key_cookdedPost)
                    postObject.setValue(dataPost.canEdit, forKey: entity_key_canEditPost)
                    postObject.setValue(dataPost.topicID, forKey: entity_key_idTopicInPost)
                    
                    try context.save()
                    
                } catch {
                    print("Error al guardar el post \(dataPost.cooked)")
                    
                }
            }
            
        }
        
    }
    
    func dataPosts(id: Int) -> Array<PostData> {
        guard let context = managedObjectContext(),
            let data = fetchDataRequest(context: context,
                                        entity: entity_namePost,
                                        predicate: "\(entity_key_idTopicInPost) = \(id)") else {
                                            return Array()
        }
        
        return data.compactMap { postCD in
            guard let postId = postCD.value(forKey: entity_key_idTopic) as? Int,
                let cooked = postCD.value(forKey: entity_key_cookdedPost) as? String,
                let canEdit = postCD.value(forKey: entity_key_canEditPost) as? Bool,
                let topicId = postCD.value(forKey: entity_key_idTopicInPost) as? Int else {
                    return nil
            }
            
            return PostData(postId: postId, cooked: cooked, canEdit: canEdit, topicId: topicId)
        }
    }
    
    
    func updatePosts(post: [Post2])  {
        
        
        for dataPost in post {
            
            guard let context = managedObjectContext(),
                let data = fetchDataRequest(context: context,
                                            entity: entity_namePost,
                                            predicate: "\(entity_key_idPost) = \(dataPost.id)"),
                let dataToUpdate = data.first else {
                    return
            }

            do {
                
                dataToUpdate.setValue(dataPost.id, forKey: entity_key_idPost)
                dataToUpdate.setValue(dataPost.cooked, forKey: entity_key_cookdedPost)
                dataToUpdate.setValue(dataPost.canEdit, forKey: entity_key_canEditPost)
                dataToUpdate.setValue(dataPost.topicID, forKey: entity_key_idTopicInPost)
                
                try context.save()
                
            } catch {
                print("Error al guardar el topic \(dataPost.cooked)")
                
            }
        }
    }
    
}


// MARK: - Database Users delegate extension

// MARK: Private properties Posts
private let entity_nameUser = "Users"
private let entity_key_nameUser = "name"
private let entity_key_userNameUser = "userName"
private let entity_key_userId = "idUser"


extension DatabaseCoreData: DatabaseUsersDelegate {
    
    func initDefaultDataUsers() {
        deleteAllDataUsers()
    }
    
    func deleteAllDataUsers() {
        guard let context = managedObjectContext() ,
            let data = fetchDataRequest(context: context,
                                        entity: entity_nameUser) else {
                                            return
        }
        
        _ = delete(data: data,
                   context: context)
    }
    
    
    func saveUsers(user: [User4])  {
        
        // deleteAllDataUsers()
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_nameUser,
                                                    in: context) else {
                                                        return
                                                        
        }
        
        for dataUser in user {
            
            if someEntityExists(id: dataUser.id, idAtribute: entity_key_userId, entityName: entity_nameUser) {
                print("Data is already present")
                return
            }
                //else create and save new user
            else {
                
                let userObject = NSManagedObject(entity: entity,
                                                 insertInto: context)
                
                
                do {
                    
                    userObject.setValue(dataUser.name, forKey: entity_key_nameUser)
                    userObject.setValue(dataUser.username, forKey: entity_key_userNameUser)
                    
                    
                    try context.save()
                    
                } catch {
                    print("Error al guardar el post \(dataUser.name)")
                    
                }
                
            }
            
        }
        
    }
    
    func dataUsers() -> Array<UserData> {
        guard let context = managedObjectContext(),
            let data = fetchDataRequest(context: context,
                                        entity: entity_nameUser) else {
                                            return Array()
        }
        
        return data.compactMap { userCD in
            guard let idUser = userCD.value(forKey: entity_key_userId) as? Int,
                let name = userCD.value(forKey: entity_key_nameUser) as? String,
                let userName = userCD.value(forKey: entity_key_userNameUser) as? String else {
                    return nil
            }
            
            return UserData(name: name, userName: userName, idUser: idUser)
        }
    }
    
    func updateUsers(user: [User4])  {
        
        
        for dataUser in user {
            
            guard let context = managedObjectContext(),
                let data = fetchDataRequest(context: context,
                                            entity: entity_nameUser,
                                            predicate: "\(entity_key_idPost) = \(dataUser.name)"),
                let dataToUpdate = data.first else {
                    return
            }

            do {
                
                dataToUpdate.setValue(dataUser.name, forKey: entity_key_nameUser)
                dataToUpdate.setValue(dataUser.username, forKey: entity_key_userNameUser)

                
                try context.save()
                
            } catch {
                print("Error al guardar el topic \(dataUser.name)")
                
            }
        }
    }
    
}

