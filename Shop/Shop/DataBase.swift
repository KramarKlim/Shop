//
//  DataBase.swift
//  Shop
//
//  Created by Клим on 12.07.2021.
//

import Foundation

import UIKit
import CoreData

class DataBase {
    
    static var shared = DataBase()
    
    var items: [Item] = []
    
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let viewContext = persistentContainer.viewContext
        do {
            items = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveItem(name: String?, count: String?, size: String?, price: String?) {
        let viewContext = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Item", in: viewContext) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? Item else { return }
//        guard let saveImage = image else { return }
//        guard let imageData = saveImage.jpegData(compressionQuality: 1.0) else { return }
        task.setValue(name, forKey: "name")
        task.setValue(count, forKey: "count")
        task.setValue(size, forKey: "size")
        task.setValue(price, forKey: "price")
//        task.setValue(image, forKey: "image")
        task.name = name
        task.count = count
        task.size = size
        task.price = price
//        task.image = imageData
        items.append(task)
        saveContext()
    }
    
    func deleteTask(for index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            context.delete(objects[index])
        }
        items.remove(at: index)
        saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
