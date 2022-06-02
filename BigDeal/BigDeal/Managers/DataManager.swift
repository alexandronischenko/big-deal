import Foundation
import Alamofire

class DataManager {
    // MARK: - Singleton
    
    static let shared = DataManager()
    // MARK: - Properties
    
    var currentSearchingItemText: String = ""
    var productRepositoryOffset: Int = 0
    var categoryRepositoryOffset: Int = 0
    var hotRepositoryOffset: Int = 0
    var limit: Int = 10
    // MARK: - Data
    
    var itemsForSearch: [Item] = []
    var itemsForCategory: [Item] = []
    var itemsForHot: [Item] = []
    var itemsForFilters: [Item] = []
    
    var data: [Item] = [
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", id: "23423414", oldPrice: "3000", newPrice: "1700", clothImage: #imageLiteral(resourceName: "img1"), url: "url", imageURL: ""),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", id: "23423414", oldPrice: "5000", newPrice: "2000", clothImage: #imageLiteral(resourceName: "img2"), url: "url", imageURL: ""),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", id: "23423414", oldPrice: "3000", newPrice: "1700", clothImage: #imageLiteral(resourceName: "img1"), url: "url", imageURL: ""),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", id: "23423414", oldPrice: "5000", newPrice: "2000", clothImage: #imageLiteral(resourceName: "img2"), url: "url", imageURL: ""),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", id: "23423414", oldPrice: "3000", newPrice: "1700", clothImage: #imageLiteral(resourceName: "img1"), url: "url", imageURL: ""),
        Item(shopTitle: "ASOS", clothTitle: "Sneakers", id: "23423414", oldPrice: "5000", newPrice: "2000", clothImage: #imageLiteral(resourceName: "img2"), url: "url", imageURL: "")
    ]
    // Access tokens
    
    var accessTokensForAsos: [String: String] = [
        "tokenForSearch": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForFeed": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForFilter": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForCategories": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f"
    ]
    
    var accessTokensForStockX: [String: String] = [
        "tokenForSearch": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForFeed": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForFilter": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForCategories": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f"
    ]
    
    var accessTokensForFarfetch: [String: String] = [
        "tokenForSearch": "1279077585mshb23d041886d9bb3p1b1539jsnfe59a7f5a95c",
        "tokenForFeed": "15801b7014mshb9c59eb4950d191p127171jsnb11bc270dac0",
        "tokenForFilter": "59360c4fc7msha024553f3b3f41dp1d5f00jsn9631e1671d9f",
        "tokenForCategories": "895743ac99msh9c876e80d25b3d8p1c7c54jsnfcc7f96fe3ae"
    ]
    // Bool
    
    var isExpandedArray: [Bool] = [
        false, false, false, false, false, false, false
    ]
    // Asos API
    
    var asosHostHeader = HTTPHeader(name: "X-RapidAPI-Host", value: "asos2.p.rapidapi.com")
    var asosProductsListUrl: URLConvertible = "https://asos2.p.rapidapi.com/products/v2/list"
    var asosAccessTokenHeaderName = "X-RapidAPI-Key"
    // StockX API
    
    var stockXHostHeader = HTTPHeader(name: "X-RapidAPI-Host", value: "stockx5.p.rapidapi.com")
    var stockXSearchUrl: String = "https://stockx5.p.rapidapi.com/search/"
    var stockXAccessTokenHeaderName = "X-RapidAPI-Key"
    // MARK: - Functions
    
    func obtainUrlForStockXSearch(searching: String) -> String {
        return "https://stockx5.p.rapidapi.com/search/" + searching
    }
    
    func obtainUrlForStockXSneakers() -> String {
        return "https://stockx5.p.rapidapi.com/search/sneaker"
    }
    
    func obtainParametersForAsosFilters(priceMin: String, priceMax: String, sortBy: String, category: String) -> Parameters? {
        return [
            "store": "US",
            "offset": "\(categoryRepositoryOffset)",
            "limit": "\(limit)",
            "categoryId": category,
            "sort": sortBy,
            "priceMin": priceMin,
            "priceMax": priceMax
        ]
    }
    
    func obtainParametersForAsosSearch(_ searchingProduct: String) -> Parameters? {
        return [
            "store": "US",
            "offset": "\(productRepositoryOffset)",
            "limit": "\(limit)",
            "q": searchingProduct
        ]
    }
    
    func obtainParametersForAsosCategory(_ categoryId: String) -> Parameters? {
        return [
            "store": "US",
            "offset": "\(categoryRepositoryOffset)",
            "limit": "\(limit)",
            "categoryId": categoryId
        ]
    }
    
    func obtainParametersForAsosHot(_ categoryId: String) -> Parameters? {
        return [
            "store": "US",
            "offset": "\(hotRepositoryOffset)",
            "limit": "\(limit)",
            "categoryId": categoryId
        ]
    }
    
    func obtainParametersForStockXSneakers() -> Parameters? {
        return [
            "page": "1",
            "limit": "10"
        ]
    }
    
    func obtainParametersForStockXSearch() -> Parameters? {
        return [
            "page": "1",
            "limit": "10"
        ]
    }
}
