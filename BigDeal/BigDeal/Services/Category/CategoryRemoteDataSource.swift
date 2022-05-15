import Foundation
import Alamofire

class CategoryRemoteDataSource: CategoryRemoteDataSourceProtocol {
    // MARK: - Private properties
    
    private let accessTokenForAsos = KeychainManager.standard.read(service: ApiServices.accessTokenForCategories.rawValue, account: ApiAccounts.asos.rawValue, type: String.self)
    private let accessTokenForStockX = KeychainManager.standard.read(service: ApiServices.accessTokenForCategories.rawValue, account: ApiAccounts.stockX.rawValue, type: String.self)
    private let accessTokenForFarfetch = KeychainManager.standard.read(service: ApiServices.accessTokenForCategories.rawValue, account: ApiAccounts.farfetch.rawValue, type: String.self)
    // MARK: - Functions
    
    // Requests from ASOS API
    
    func obtainProductByCategoryIdFromAsos(_ categoryId: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        guard let accessTokenForAsos = accessTokenForAsos else {
            return
        }
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "asos2.p.rapidapi.com",
            "X-RapidAPI-Key": accessTokenForAsos
        ]
        let parameters = [
            "store": "US",
            "offset": "0",
            "categoryId": categoryId,
            "limit": "48",
            "country": "US",
            "sort": "freshness",
            "currency": "USD",
            "sizeSchema": "US",
            "lang": "en-US"
        ]
        let url = "https://asos2.p.rapidapi.com/products/v2/list"
//        DispatchQueue.global(qos: .utility).async {
//        }
        DispatchQueue.init(label: "", qos: .utility, attributes: .concurrent).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                completion(response)
            }
        //}
        }
    }
    // Requests from StockX API
    
    func obtainProductByCategoryFromStockX(_ category: String, completion: @escaping(AFDataResponse<Any>) -> Void) {
        guard let accessTokenForStockX = accessTokenForStockX else {
            return
        }
        let headers: HTTPHeaders = [
            "X-RapidAPI-Host": "stockx1.p.rapidapi.com",
            "X-RapidAPI-Key": accessTokenForStockX
        ]
        let parameters = [
            "q": category,
            "currency": "EUR"
        ]
        let url = "https://stockx1.p.rapidapi.com/api/v1/stockx/trends"
        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
                completion(response)
            }
        }
    }
}
