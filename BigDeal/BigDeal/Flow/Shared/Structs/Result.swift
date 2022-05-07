import Foundation

struct Result: Codable {
    let products: [Product]
}

struct Product: Codable {
    let name: String
    let price: Price
    let url: String
    let imageUrl: String
    let brandName: String
}

struct Price: Codable {
    let current: CurrentPrice
    let previous: PreviousPrice
}

struct CurrentPrice: Codable {
    let text: String
}

struct PreviousPrice: Codable {
    let text: String
}
