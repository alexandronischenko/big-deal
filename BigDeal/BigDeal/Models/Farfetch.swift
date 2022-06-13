import Foundation

struct Farfetch: Codable {
    let products: FarfetchProduct
}

struct FarfetchProduct: Codable {
    let entries: [Entry]
}

struct Entry: Codable {
    let brand: Brand
    let images: [FarfetchImage]
    let price: String
}

struct Brand: Codable {
    let name: String
}

struct FarfetchImage: Codable {
    let url: String
}
