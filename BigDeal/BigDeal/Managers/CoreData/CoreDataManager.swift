import Foundation
import CoreData
import UIKit

// MARK: - Core Data stack

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BigDeal")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
}

// MARK: - CRUD

extension CoreDataManager: CoreDataManagerProtocol {
    func addToFavorites(model: Item, completion: @escaping (Result<Item, Error>) -> Void) {
        model.isFavorite = true
        
        let item = ItemEntity(context: self.context)
        
        FileManagerService.shared.saveImage(image: model.clothImage, with: model.id) { result in
            switch result {
            case .success(let url):
                item.imageUrl = url
            case .failure:
                break
            }
        }
        
        item.newPrice = model.newPrice
        item.oldPrice = model.oldPrice
        item.id = model.id
        item.url = model.url
        item.name = model.clothTitle
        
        do {
            try self.context.save()
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteFromFavorites(model: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", model.id)
        
        do {
            let items = try context.fetch(fetchRequest) as? [ItemEntity]
            guard let item = items?.first else { return }
            context.delete(item)
            completion(.success(true))
        } catch {
            Logger.log(level: .error, str: "Error: \(error.localizedDescription)", shouldLogContext: true)
            completion(.failure(error))
        }
    }
    
    func getAllFavorites(completion: @escaping (Result<[Item], Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
        
        do {
            let items = try context.fetch(fetchRequest) as? [ItemEntity]
            if let result = items?.reduce(into: [Item](), { partialResult, i in
                var downloadedImage = UIImage()
                guard
                    let name = i.name,
                    let id = i.id,
                    let oldPrice = i.oldPrice,
                    let newPrice = i.newPrice,
                    let imageURL = i.imageUrl,
                    let url = i.url else {
                    return
                }
                
                FileManagerService.shared.getImage(byID: id) { result in
                    switch result {
                    case .success(let image):
                        downloadedImage = image
                    case .failure:
                        break
                    }
                }
                
                let item = Item(shopTitle: name, clothTitle: name, id: id, oldPrice: oldPrice, newPrice: newPrice, clothImage: downloadedImage, url: url, imageURL: imageURL)
                partialResult.append(item)
            }) {
                completion(.success(result))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func isFavorite(model: Item, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", model.id)
        
        do {
            let items = try context.fetch(fetchRequest) as? [ItemEntity]
            if (items?.first) != nil {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        } catch {
            Logger.log(level: .error, str: "Error: \(error.localizedDescription) ", shouldLogContext: true)
            completion(.failure(error))
        }
    }
    
    func delete(completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            completion(.success(true))
        } catch let error {
            Logger.log(level: .error, str: "Error: \(error.localizedDescription) ", shouldLogContext: true)
            completion(.failure(error))
        }
    }
    
    func saveContext() {
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
