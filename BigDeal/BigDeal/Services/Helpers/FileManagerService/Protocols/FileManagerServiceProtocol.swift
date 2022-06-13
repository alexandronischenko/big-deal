import Foundation
import UIKit

protocol FileManagerServiceProtocol {
    // Function that save image on device and return Result type where String is URL of saved images
    func saveImage(image: UIImage, with identifier: String, completion: @escaping ((Result<String, Error>) -> Void))
    
    // Function that returnes saved image from device by URL and return Result type where UIImage is a saved image
    func getImage(byID: String, completion: @escaping ((Result<UIImage, Error>) -> Void))
}
