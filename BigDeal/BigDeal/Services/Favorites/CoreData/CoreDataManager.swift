import Foundation
import CoreData
import UIKit

// MARK: - Core Data stack

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BigDeal")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
}

// MARK: - CRUD

extension CoreDataManager: CoreDataManagerProtocol {
    func addToFavorites(model: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
        let item = ItemEntity(context: context)
        // MARK: - DATAMANAGER download image
        item.imageUrl = "model.clothImage"
        
        item.newPrice = model.newPrice
        item.oldPrice = model.oldPrice
        item.id = model.id
        item.url = model.url
        item.name = model.clothTitle
        
        do {
            try context.save()
        } catch {
            completion(.failure(error))
        }
        completion(.success(true))
    }
    
    func deleteFromFavorites(model: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
    }
    
    func getAllFavorites(completion: @escaping (Result<[Item], Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
        
        do {
            let items = try context.fetch(fetchRequest) as? [ItemEntity]
            if let result = items?.reduce(into: [Item](), { partialResult, i in
                // MARK: - DATAMANAGER download image
                
                let image = UIImage()
                
                guard let name = i.name,
                      let id = i.id,
                      let oldPrice = i.oldPrice,
                      let newPrice = i.newPrice,
                      let imageURL = i.imageUrl,
                      let url = i.url else { return }
                
                let item = Item(shopTitle: name, clothTitle: name, id: id, oldPrice: oldPrice, newPrice: newPrice, clothImage: image, url: url)
                
                partialResult.append(item)
            }) {
                completion(.success(result))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func isFavorite(model: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
