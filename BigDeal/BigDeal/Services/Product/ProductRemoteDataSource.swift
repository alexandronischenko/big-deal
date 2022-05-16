import Foundation
import Alamofire

class ProductRemoteDataSource: ProductRemoteDataSourceProtocol {
    // MARK: - Private properties
    
    private let accessTokenForAsos = KeychainManager.standard.read(service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.asos.rawValue, type: String.self)
    private let accessTokenForStockX = KeychainManager.standard.read(service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.stockX.rawValue, type: String.self)
    private let accessTokenForFarfetch = KeychainManager.standard.read(service: ApiServices.accessTokenForSearch.rawValue, account: ApiAccounts.farfetch.rawValue, type: String.self)
    // MARK: - Functions
    
    // Requests to ASOS API
    
    func obtainProductByNameFromAsos(with parameters: Parameters?, headers: HTTPHeaders?, url: URLConvertible, completion: @escaping(AFDataResponse<Any>) -> Void) {
//        guard let accessTokenForAsos = accessTokenForAsos else {
//            return
//        }
//        let headers: HTTPHeaders = [
//            "X-RapidAPI-Host": "asos2.p.rapidapi.com",
//            "X-RapidAPI-Key": accessTokenForAsos
//        ]
//        let parameters = [
//            "store": "US",
//            "offset": String(offset),
//            "limit": String(limit),
//            "country": "US",
//            "sort": "freshness",
//            "q": name,
//            "currency": "USD",
//            "sizeSchema": "US",
//            "lang": "en-US"
//        ]
//        let url = "https://asos2.p.rapidapi.com/products/v2/list"
        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                completion(response)
            }
        }
    }
    // Requests to StockX API
    
    func obtainProductByNameFromStockX(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        guard let accessTokenForStockX = accessTokenForStockX else {
            return
        }
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "stockx5.p.rapidapi.com",
            "X-RapidAPI-Key": accessTokenForStockX
        ]
        let parameters = [
            "q": name,
            "limit": "10",
            "page": "1"
        ]
        let url = "https://stockx5.p.rapidapi.com/search"
        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                completion(response)
            }
        }
    }
    // Requests to Farfetch API
    
    func obtainProductByNameFromFarfetch(name: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        guard let accessTokenForFarfetch = accessTokenForFarfetch else {
            return
        }
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "farfetch-data.p.rapidapi.com",
            "X-RapidAPI-Key": accessTokenForFarfetch
        ]
        let parameters = [
            "keyword": name,
            "page": "1",
            "sort": "low_to_high"
        ]
        let url = "https://farfetch-data.p.rapidapi.com/search.php?"
        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
                completion(response)
            }
        }
    }
}
