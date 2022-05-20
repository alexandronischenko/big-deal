import Foundation

struct StockX: Codable {
    let stockXData: StockXData
    
    private enum CodingKeys: String, CodingKey {
        case stockXData = "data"
    }
}

struct StockXData: Codable {
    let stockXItems: [StockXItem]
    
    private enum CodingKeys: String, CodingKey {
        case stockXItems = "items"
    }
}

struct StockXItem: Codable {
    let id: String
    let url: String
    let name: String
    let brand: String
    let image: String
}
