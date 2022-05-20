import Foundation
import UIKit

struct Item {
    // MARK: - Properties
    
    var clothImage: UIImage
    var clothTitle: String
    var oldPrice: String
    var newPrice: String
    var url: String
    var id: String
    var isFavorite: Bool = false

    // MARK: - Initializers
    
    init?(product: AsosProduct) {
        guard
            let clothTitle = String?(product.name),
            let oldPrice = String?(product.price.previous.text),
            let newPrice = String?(product.price.current.text),
            let clothUrl = URL(string: "https://" + product.imageUrl),
            let clothData = try? Data(contentsOf: clothUrl),
            let clothImage = UIImage(data: clothData),
            let url = String?("https://www.asos.com/us" + product.url),
            let id = String?("\(product.id)")
        else {
            return nil
        }
        if oldPrice.isEmpty {
            self.oldPrice = newPrice
        } else {
            self.oldPrice = oldPrice
        }
        self.clothImage = clothImage
        self.newPrice = newPrice
        self.clothTitle = clothTitle
        self.url = url
        self.id = id
    }
    
//    init?(stockXProduct: StockXProduct) {
//        guard
//            let oldPrice = String?("Sold"),
//            let newPrice = String?("Buy"),
//            let clothUrl = URL(string: stockXProduct.media.thumbUrl),
//            let clothData = try? Data(contentsOf: clothUrl),
//            let clothImage = UIImage(data: clothData),
//            let clothTitle = String?("\(stockXProduct.title)"),
//            let clothUrl = String?("https://stockx.com" + "\(stockXProduct.urlKey)"),
//            let id = String?("\(stockXProduct.objectID)")
//        else {
//            return nil
//        }
//        self.oldPrice = oldPrice
//        self.clothImage = clothImage
//        self.newPrice = newPrice
//        self.clothTitle = clothTitle
//        self.url = clothUrl
//        self.id = id
//    }
    
    init?(entry: Entry) {
        guard
            let oldPrice = String?(entry.price),
            let newPrice = String?(entry.price),
            let clothUrl = URL(string: entry.images[9].url),
            let clothData = try? Data(contentsOf: clothUrl),
            let clothImage = UIImage(data: clothData),
            let clothTitle = String?("title")
        else {
            return nil
        }
        self.oldPrice = oldPrice
        self.clothImage = clothImage
        self.newPrice = newPrice
        self.clothTitle = clothTitle
        self.url = ""
        self.id = ""
    }
    
    init(shopTitle: String, clothTitle: String, id: String, oldPrice: String, newPrice: String, clothImage: UIImage, url: String) {
        self.oldPrice = oldPrice
        self.newPrice = newPrice
        self.clothImage = clothImage
        self.clothTitle = clothTitle
        self.url = url
        self.id = id
    }
    // MARK: - Static functions

    static func getAsosArray(from products: [AsosProduct]) -> [Item]? {
        var items: [Item] = []
        for product in products {
            if let item = Item(product: product) {
                items.append(item)
            }
        }
        return items
    }
    
//    static func getStockXArray(from stockXProducts: [StockXProduct]) -> [Item]? {
//        var items: [Item] = []
//        for stockXProduct in stockXProducts {
//            if let item = Item(stockXProduct: stockXProduct) {
//                items.append(item)
//            }
//        }
//        return items
//    }
    
    static func getFarfetchArray(from entries: [Entry]) -> [Item]? {
        var items: [Item] = []
        for entry in entries {
            if let item = Item(entry: entry) {
                items.append(item)
            }
        }
        return items
    }
}
