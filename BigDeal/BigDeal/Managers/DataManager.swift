import Foundation

class DataManager {
    // MARK: - Properties
    
    static let shared = DataManager()
    
    var data: [Item] = [
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", sizes: ["42", "43", "44"], oldPrice: "3000", newPrice: "1700", clothImage: #imageLiteral(resourceName: "img1")),
        Item(shopTitle: "Stockx", clothTitle: "Sneakers", sizes: ["37", "38", "39"], oldPrice: "12900", newPrice: "3434", clothImage: #imageLiteral(resourceName: "img2")),
        Item(shopTitle: "Farfetch", clothTitle: "Sneakers", sizes: ["40"], oldPrice: "545542", newPrice: "21212", clothImage: #imageLiteral(resourceName: "img1")),
        Item(shopTitle: "Yoox", clothTitle: "Hoodie", sizes: ["M", "S"], oldPrice: "3333", newPrice: "1333", clothImage: #imageLiteral(resourceName: "img2")),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", sizes: ["42", "43", "44"], oldPrice: "3000", newPrice: "1700", clothImage: #imageLiteral(resourceName: "img1")),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", sizes: ["42", "43", "44"], oldPrice: "3000", newPrice: "1700", clothImage: #imageLiteral(resourceName: "img2")),
        Item(shopTitle: "Farfetch", clothTitle: "Sneakers", sizes: ["40"], oldPrice: "545542", newPrice: "21212", clothImage: #imageLiteral(resourceName: "img1")),
        Item(shopTitle: "Yoox", clothTitle: "Hoodie", sizes: ["M", "S"], oldPrice: "3333", newPrice: "1333", clothImage: #imageLiteral(resourceName: "img2")),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", sizes: ["42", "43", "44"], oldPrice: "3000", newPrice: "1700", clothImage: #imageLiteral(resourceName: "img1")),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", sizes: ["42", "43", "44"], oldPrice: "3000", newPrice: "1700", clothImage: #imageLiteral(resourceName: "img2"))
    ]
}
