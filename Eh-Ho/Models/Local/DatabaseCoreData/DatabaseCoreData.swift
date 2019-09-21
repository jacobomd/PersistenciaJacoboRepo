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
    
    

    
    private func someEntityExists2(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SomeEntity")
        fetchRequest.includesSubentities = false
        
        var entitiesCount = 0
        
        do {
            entitiesCount = try managedObjectContext()!.count(for: fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return entitiesCount > 0
    }
    
//    private func autoincrementID(context: NSManagedObjectContext) -> Int {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_name)
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: entity_key_idCategory, ascending: false)]
//
//        do {
//            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject],
//                let maxId = data.first?.value(forKey: entity_key_idCategory) as? Int else {
//                    return 0
//            }
//
//            return maxId + 1
//        } catch {
//            print("Error al generar autoincrement id")
//            return 0
//        }
//    }
    
//    private func findData(done: Bool) -> Array<CategoryData> {
//        guard let context = managedObjectContext(),
//            let data = fetchDataRequest(context: context,
//                                        entity: entity_name,
//                                        predicate: "\(entity_key_isDone) = \(done)") else {
//                                            return Array()
//        }
//        
//        return categoriesData(from: data)
//    }
    
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
    

    
    //    private func categoriesData(from categoryCD: [NSManagedObject]) -> Array<CategoryData> {
    //        return categoryCD.compactMap { categoryCD in
    //            guard let id = categoryCD.value(forKey: entity_key_id) as? Int,
    //                let name = categoryCD.value(forKey: entity_key_name) as? String else {
    //                    return nil
    //            }
    //
    //            return CategoryData(categoryId: id,
    //                                name: name)
    //        }
    //    }
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
    
    
    
    
    private func someEntityExists(id: Int, entityName: String) -> Bool {
        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "someField = %d", id)
        
        var results: [NSManagedObject] = []
        
        do {
            results = try (managedObjectContext()?.fetch(fetchRequest))!
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    
    

    
    func saveCategories(category: [Category])  {
        
       // deleteAllDataCategories()
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_nameCategory,
                                                    in: context) else {
        return

        }

        for dataCategory in category {
            
                    let taskObject = NSManagedObject(entity: entity,
                                                     insertInto: context)
        
//           save(object: taskObject,
//                into: context,
//                id: dataCategory.id,
//                name: dataCategory.name)
            
            do {
                
                taskObject.setValue(dataCategory.id, forKey: entity_key_idCategory)
                
                taskObject.setValue(dataCategory.name, forKey: entity_key_nameCategory)
                
                try context.save()
                
            } catch {
                print("Error al guardar la categoria: \(dataCategory.name)")
               
            }
            
        }
        
    }
    
    func updateCategories(category: [Category])  {

        
        for dataCategory in category {
            
            guard let context = managedObjectContext(),
                let data = fetchDataRequest(context: context,
                                            entity: entity_nameCategory,
                                            predicate: "\(entity_key_idCategory) = \(dataCategory.id)"),
                let dataToUpdate = data.first else {
                    return
            }
        
//        save(object: dataToUpdate,
//                    into: context,
//                    id: dataCategory.id,
//                    name: dataCategory.name)
            
            do {
                
                dataToUpdate.setValue(dataCategory.id, forKey: entity_key_idCategory)
                
                dataToUpdate.setValue(dataCategory.name, forKey: entity_key_nameCategory)
                
                try context.save()
                
            } catch {
                print("Error al guardar la categoria: \(dataCategory.name)")
                
            }
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
        
        deleteAllDataTopics()
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_nameTopic,
                                                    in: context) else {
                                                        return
                                                        
        }
        
        for dataTopic in topic {
            
            let taskObject = NSManagedObject(entity: entity,
                                             insertInto: context)
            
//            save(object: taskObject,
//                 into: context,
//                 id: dataTopic.id,
//                 name: dataTopic.title)
            
            do {
                
                taskObject.setValue(dataTopic.id, forKey: entity_key_idTopic)
                taskObject.setValue(dataTopic.title, forKey: entity_key_titleTopic)
                taskObject.setValue(dataTopic.views, forKey: entity_key_viewsTopic)
                taskObject.setValue(dataTopic.categoryID, forKey: entity_key_idCategory)
                
                try context.save()
                
            } catch {
                print("Error al guardar el topic \(dataTopic.title)")
                
            }
            
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
            
//            save(object: dataToUpdate,
//                 into: context,
//                 id: dataTopic.id,
//                 name: dataTopic.title)
            
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
        
        deleteAllDataPosts()
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_namePost,
                                                    in: context) else {
                                                        return
                                                        
        }
        
        for dataPost in post {
            
            let postObject = NSManagedObject(entity: entity,
                                             insertInto: context)
            
            //            save(object: taskObject,
            //                 into: context,
            //                 id: dataTopic.id,
            //                 name: dataTopic.title)
            
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
    
    func updatePosts(post: [Post2])  {
        
        
        for dataPost in post {
            
            guard let context = managedObjectContext(),
                let data = fetchDataRequest(context: context,
                                            entity: entity_namePost,
                                            predicate: "\(entity_key_idPost) = \(dataPost.id)"),
                let dataToUpdate = data.first else {
                    return
            }
            
            //            save(object: dataToUpdate,
            //                 into: context,
            //                 id: dataTopic.id,
            //                 name: dataTopic.title)
            
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
        
        deleteAllDataUsers()
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_nameUser,
                                                    in: context) else {
                                                        return
                                                        
        }
        
        for dataUser in user {
            
            let userObject = NSManagedObject(entity: entity,
                                             insertInto: context)
            
            //            save(object: taskObject,
            //                 into: context,
            //                 id: dataTopic.id,
            //                 name: dataTopic.title)
            
            do {
                
                userObject.setValue(dataUser.name, forKey: entity_key_nameUser)
                userObject.setValue(dataUser.username, forKey: entity_key_userNameUser)

                
                try context.save()
                
            } catch {
                print("Error al guardar el post \(dataUser.name)")
                
            }
            
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
            
            //            save(object: dataToUpdate,
            //                 into: context,
            //                 id: dataTopic.id,
            //                 name: dataTopic.title)
            
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





//    func dataCategories() -> Array<Category> {
//        guard let context = managedObjectContext(),
//            let data = fetchDataRequest(context: context,
//                                        entity: entity_name) else {
//                                            return Array()
//        }
//
//        return categoriesData(from: data)
//    }
//
//    func findTaskBy(id: Int) -> TaskData? {
//        guard let context = managedObjectContext(),
//            let data = fetchDataRequest(context: context,
//                                        entity: entity_name,
//                                        predicate: "\(entity_key_id) = \(id)") else {
//                                            return nil
//        }
//
//        return categoriesData(from: data).first
//    }
//
//    func findTasksBy(state: TaskState) -> Array<TaskData> {
//        switch state {
//        case .all:
//            return data()
//
//        case .done:
//            return findData(done: true)
//
//        case .todo:
//            return findData(done: false)
//        }
//    }
