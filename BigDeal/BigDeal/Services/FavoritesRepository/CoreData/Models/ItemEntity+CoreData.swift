import Foundation
import CoreData

@objc(ItemEntity)
public class ItemEntity: NSManagedObject {
}

extension ItemEntity {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var newPrice: String?
    @NSManaged public var oldPrice: String?
    @NSManaged public var url: String?
}
