import Foundation

struct StockX: Codable {
    let stockXPagination: StockXPagination
    let stockXProducts: [StockXProduct]
    
    private enum CodingKeys: String, CodingKey {
        case stockXPagination = "Pagination"
        case stockXProducts = "Products"
    }
}

struct StockXPagination: Codable {
    let query: String
    let limit: String
    let page: Int
    let total: Int
}

struct StockXProduct: Codable {
    let media: StockXMedia
    let title: String
    let urlKey: String
    let objectID: String
}

struct StockXMedia: Codable {
    let thumbUrl: String
}
