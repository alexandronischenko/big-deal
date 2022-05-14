import Foundation
import UIKit

struct Item {
    var clothImage: UIImage
    var clothTitle: String
    var oldPrice: String
    var newPrice: String
    var url: String
    
    init?(product: AsosProduct) {
        guard
            let clothTitle = String?(product.name),
            let oldPrice = String?(product.price.previous.text),
            let newPrice = String?(product.price.current.text),
            let clothUrl = URL(string: "https://" + product.imageUrl),
            let clothData = try? Data(contentsOf: clothUrl),
            let clothImage = UIImage(data: clothData),
            let url = String?("https://www.asos.com/us" + product.url)
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
    }
    
    init?(stockXItem: StockXItem) {
        guard
            let oldPrice = String?("Sold"),
            let newPrice = String?("Buy"),
            let clothUrl = URL(string: stockXItem.image),
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
    }
    
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
    }
    
    init(shopTitle: String, clothTitle: String, sizes: [String], oldPrice: String, newPrice: String, clothImage: UIImage) {
        self.oldPrice = oldPrice
        self.newPrice = newPrice
        self.clothImage = clothImage
        self.clothTitle = "title"
        self.url = ""
    }

    static func getAsosArray(from products: [AsosProduct]) -> [Item]? {
        var items: [Item] = []
        for product in products {
            if let item = Item(product: product) {
                items.append(item)
            }
        }
        return items
    }
    
    static func getStockXArray(from stockXItems: [StockXItem]) -> [Item]? {
        var items: [Item] = []
        for stockXItem in stockXItems {
            if let item = Item(stockXItem: stockXItem) {
                items.append(item)
            }
        }
        return items
    }
    
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
