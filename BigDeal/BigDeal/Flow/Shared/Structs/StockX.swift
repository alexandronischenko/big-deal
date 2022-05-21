import Foundation

struct StockX: Codable {
    let products: [StockXProduct]
    
    private enum CodingKeys: String, CodingKey {
        case products = "Products"
    }
}

struct StockXProduct: Codable {
    let brand: String
    let media: StockXMedia
    let productCategory: String
    let urlKey: String
    let title: String
    let objectID: String
}

struct StockXMedia: Codable {
    let thumbUrl: String
}
