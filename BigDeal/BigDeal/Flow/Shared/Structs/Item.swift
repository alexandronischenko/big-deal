import Foundation
import UIKit

struct Item {
    var shopTitle: String
    var clothTitle: String
    var sizes: [String]
    var oldPrice: String
    var newPrice: String
    var clothImage: UIImage
    
    init?(product: Product) {
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
    
    init(shopTitle: String, clothTitle: String, sizes: [String], oldPrice: String, newPrice: String, clothImage: UIImage) {
        self.shopTitle = shopTitle
        self.clothTitle = clothTitle
        self.sizes = sizes
        self.oldPrice = oldPrice
        self.newPrice = newPrice
        self.clothImage = clothImage
    }

    static func getArray(from products: [Product]) -> [Item]? {
        var items: [Item] = []
        for product in products {
            if let item = Item(product: product) {
                items.append(item)
            }
        }
        return items
    }
}
