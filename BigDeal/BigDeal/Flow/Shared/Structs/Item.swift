import Foundation
import UIKit

struct Item {
    var shopTitle: String
    var clothTitle: String
    var sizes: [String]
    var oldPrice: String
    var newPrice: String
    var clothImage: UIImage
    
    init?(product: AsosProduct) {
        guard
            let shopTtile = String?("Asos"),
            let clothTitle = String?(product.brandName),
            let sizes = [String]?([""]),
            let oldPrice = String?(product.price.previous.text),
            let newPrice = String?(product.price.current.text),
            let clothUrl = URL(string: "https://" + product.imageUrl),
            let clothData = try? Data(contentsOf: clothUrl),
            let clothImage = UIImage(data: clothData)
        else {
            return nil
        }
        if oldPrice.isEmpty {
            self.oldPrice = newPrice
        } else {
            self.oldPrice = oldPrice
        }
        self.clothImage = clothImage
        self.shopTitle = shopTtile
        self.clothTitle = clothTitle
        self.sizes = sizes
        self.newPrice = newPrice
    }
    
    init?(stockXItem: StockXItem) {
        guard
            let shopTtile = String?("StockX"),
            let clothTitle = String?(stockXItem.brand),
            let sizes = [String]?([""]),
            let oldPrice = String?("Sold"),
            let newPrice = String?("Buy"),
            let clothUrl = URL(string: stockXItem.image),
            let clothData = try? Data(contentsOf: clothUrl),
            let clothImage = UIImage(data: clothData)
        else {
            return nil
        }
        self.oldPrice = oldPrice
        self.clothImage = clothImage
        self.shopTitle = shopTtile
        self.clothTitle = clothTitle
        self.sizes = sizes
        self.newPrice = newPrice
    }
    
    init?(entry: Entry) {
        guard
            let shopTtile = String?("Farfetch"),
            let clothTitle = String?(entry.brand.name),
            let sizes = [String]?([""]),
            let oldPrice = String?(entry.price),
            let newPrice = String?(entry.price),
            let clothUrl = URL(string: entry.images[9].url),
            let clothData = try? Data(contentsOf: clothUrl),
            let clothImage = UIImage(data: clothData)
        else {
            return nil
        }
        self.oldPrice = oldPrice
        self.clothImage = clothImage
        self.shopTitle = shopTtile
        self.clothTitle = clothTitle
        self.sizes = sizes
        self.newPrice = newPrice
    }
    
    init(shopTitle: String, clothTitle: String, sizes: [String], oldPrice: String, newPrice: String, clothImage: UIImage) {
        self.shopTitle = shopTitle
        self.clothTitle = clothTitle
        self.sizes = sizes
        self.oldPrice = oldPrice
        self.newPrice = newPrice
        self.clothImage = clothImage
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
