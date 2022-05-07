import Foundation
import Alamofire

protocol SearchMainPresenterOutputProtocol: AnyObject {
    func updateData(data: [Item])
    func obtainProductByNameFromAsos(name: String, completion: @escaping(AFDataResponse<Any>) -> Void)
}
