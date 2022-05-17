import Foundation
import Alamofire

class HotRemoteDataSource: HotRemoteDataSourceProtocol {
    // MARK: - Private properties
    
    private let accessTokenForAsos = KeychainManager.standard.read(service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.asos.rawValue, type: String.self)
    private let accessTokenForStockX = KeychainManager.standard.read(service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.stockX.rawValue, type: String.self)
    private let accessTokenForFarfetch = KeychainManager.standard.read(service: ApiServices.accessTokenForFeed.rawValue, account: ApiAccounts.farfetch.rawValue, type: String.self)
    // MARK: - Functions
    
    // Requests from ASOS API
    
    func obtainHotProductsFromAsos(completion: @escaping(AFDataResponse<Any>) -> Void) {
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
            "categoryId": "28235",
            "limit": "100",
            "country": "US",
            "sort": "freshness",
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
}
