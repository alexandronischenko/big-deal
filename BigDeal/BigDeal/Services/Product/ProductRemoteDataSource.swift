import Foundation
import Alamofire

class ProductRemoteDataSource: ProductRemoteDataSourceProtocol {
    // MARK: - Private properties
    
    private let accessToken = "1279077585mshb23d041886d9bb3p1b1539jsnfe59a7f5a95c"
    // MARK: - Functions
    
    // Requests from ASOS API
    
    func obtainProductByNameFromAsos(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "asos2.p.rapidapi.com",
            "X-RapidAPI-Key": accessToken
        ]
        let parameters = [
            "store": "US",
            "offset": "0",
            "limit": "48",
            "country": "US",
            "sort": "freshness",
            "q": name,
            "currency": "USD",
            "sizeSchema": "US",
            "lang": "en-US"
        ]
        let url = "https://asos2.p.rapidapi.com/products/v2/list"
        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                completion(response)
            }
        }
    }
    // Requests from StockX API
    
    func obtainProductByNameFromStockX(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "stockx1.p.rapidapi.com",
            "X-RapidAPI-Key": accessToken
        ]
        let parameters = [
            "q": name,
            "limit": "10",
            "page": "1"
        ]
        let url = "https://stockx1.p.rapidapi.com/api/v1/stockx/search"
        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                completion(response)
            }
        }
    }
}
