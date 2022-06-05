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
        "tokenForSearch": "a1639e977bmsha71b7798b57eaddp1e7152jsne2f543546c88",
        "tokenForFeed": "0f33d03f83mshf7755911431a4d6p1bcc78jsnf15bc8704910",
        "tokenForFilter": "866e4ba640msh40a0746e826a3edp1c9ce9jsn7309f4ac09f5",
        "tokenForCategories": "ed15ce6e40msh00e720830144f3ep153498jsna6abd0f7549b"
    ]
    
    var accessTokensForStockX: [String: String] = [
        "tokenForSearch": "a1639e977bmsha71b7798b57eaddp1e7152jsne2f543546c88",
        "tokenForFeed": "0f33d03f83mshf7755911431a4d6p1bcc78jsnf15bc8704910",
        "tokenForFilter": "866e4ba640msh40a0746e826a3edp1c9ce9jsn7309f4ac09f5",
        "tokenForCategories": "ed15ce6e40msh00e720830144f3ep153498jsna6abd0f7549b"
    ]
    
    var accessTokensForFarfetch: [String: String] = [
        "tokenForSearch": "a1639e977bmsha71b7798b57eaddp1e7152jsne2f543546c88",
        "tokenForFeed": "0f33d03f83mshf7755911431a4d6p1bcc78jsnf15bc8704910",
        "tokenForFilter": "866e4ba640msh40a0746e826a3edp1c9ce9jsn7309f4ac09f5",
        "tokenForCategories": "ed15ce6e40msh00e720830144f3ep153498jsna6abd0f7549b"
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
