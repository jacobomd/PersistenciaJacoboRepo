//
//  DatabaseCoreDataCategories.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 17/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit
import CoreData

class DatabaseCoreDataCategories {
    // MARK: Private properties
    private let entity_name = "Categories"
    private let entity_key_id = "categoryId"
    private let entity_key_name = "name"
    
    
    // MARK: Private methods
    private func managedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    private func autoincrementID(context: NSManagedObjectContext) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity_name)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: entity_key_id, ascending: false)]
        
        do {
            guard let data = try context.fetch(fetchRequest) as? [NSManagedObject],
                let maxId = data.first?.value(forKey: entity_key_id) as? Int else {
                    return 0
            }
            
            return maxId + 1
        } catch {
            print("Error al generar autoincrement id")
            return 0
        }
    }
    
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
    
    private func save(object: NSManagedObject, into context: NSManagedObjectContext, id: Int, name: String) -> Bool {
        do {
            
            object.setValue(id, forKey: entity_key_id)
            
            object.setValue(name, forKey: entity_key_name)

            try context.save()
            return true
        } catch {
            print("Error al guardar la categoria: \(name)")
            return false
        }
    }
    
    private func categoriesData(from categoryCD: [NSManagedObject]) -> Array<CategoryData> {
        return categoryCD.compactMap { categoryCD in
            guard let id = categoryCD.value(forKey: entity_key_id) as? Int,
                let name = categoryCD.value(forKey: entity_key_name) as? String else {
                    return nil
            }
            
            return CategoryData(categoryId: id,
                                name: name)
        }
    }
}


// MARK: - Database delegate extension
extension DatabaseCoreDataCategories: DatabaseCategoriesDelegate {
    func initDefaultData() {
        deleteAllData()
    }
    
    func deleteAllData() {
        guard let context = managedObjectContext() ,
            let data = fetchDataRequest(context: context,
                                        entity: entity_name) else {
                                            return
        }

        _ = delete(data: data,
                   context: context)
    }

    
    func save(category: [Category])  {
        
        deleteAllData()
        
        guard let context = managedObjectContext(),
            let entity = NSEntityDescription.entity(forEntityName: entity_name,
                                                    in: context) else {
        return

        }

        for dataCategory in category {
            
                    let taskObject = NSManagedObject(entity: entity,
                                                     insertInto: context)
        
           save(object: taskObject,
                into: context,
                id: dataCategory.id,
                name: dataCategory.name)
            
        }
        
    }
    

    func data() -> Array<CategoryData> {
        guard let context = managedObjectContext(),
            let data = fetchDataRequest(context: context,
                                        entity: entity_name) else {
                                            return Array()
        }

        return categoriesData(from: data)
    }
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
}
