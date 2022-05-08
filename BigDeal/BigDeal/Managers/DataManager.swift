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
    
    var accessTokensForAsos: [String: String] = [
        "tokenForSearch": "1279077585mshb23d041886d9bb3p1b1539jsnfe59a7f5a95c",
        "tokenForFeed": "15801b7014mshb9c59eb4950d191p127171jsnb11bc270dac0",
        "tokenForFilter": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForCategories": "895743ac99msh9c876e80d25b3d8p1c7c54jsnfcc7f96fe3ae"
    ]
    
    var accessTokensForStockX: [String: String] = [
        "tokenForSearch": "1279077585mshb23d041886d9bb3p1b1539jsnfe59a7f5a95c",
        "tokenForFeed": "15801b7014mshb9c59eb4950d191p127171jsnb11bc270dac0",
        "tokenForFilter": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForCategories": "895743ac99msh9c876e80d25b3d8p1c7c54jsnfcc7f96fe3ae"
    ]
    
    var accessTokensForFarfetch: [String: String] = [
        "tokenForSearch": "1279077585mshb23d041886d9bb3p1b1539jsnfe59a7f5a95c",
        "tokenForFeed": "15801b7014mshb9c59eb4950d191p127171jsnb11bc270dac0",
        "tokenForFilter": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForCategories": "895743ac99msh9c876e80d25b3d8p1c7c54jsnfcc7f96fe3ae"
    ]
    
    var isExpandedArray: [Bool] = [
        false, false, false, false, false, false, false
    ]
    
    var isDoneArray: [Bool] = [
    ]
}
