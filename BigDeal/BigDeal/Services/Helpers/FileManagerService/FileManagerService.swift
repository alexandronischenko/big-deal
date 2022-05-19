import Foundation
import UIKit

private enum FileManagerErrors: Error {
    case didNotFindDocumentDirectory
    case couldNotRemoveFileAtPath(path: String)
    case errorWithSavingFile
    case errorWithGettingImage
}

final class FileManagerService {
    static let shared = FileManagerService()
    
    private init() {}
}

extension FileManagerService: FileManagerServiceProtocol {
    func saveImage(image: UIImage, with identifier: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(.failure(FileManagerErrors.didNotFindDocumentDirectory))
            return
        }
        let fileName = identifier
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                completion(.failure(FileManagerErrors.couldNotRemoveFileAtPath(path: removeError.localizedDescription)))
            }
        }
        
        do {
            try data.write(to: fileURL)
        } catch {
            completion(.failure(FileManagerErrors.errorWithSavingFile))
        }
    }
    
    func getImage(byID: String, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(byID)
            guard let image = UIImage(contentsOfFile: imageUrl.path) else {
                completion(.failure(FileManagerErrors.errorWithGettingImage))
                return
            }
            completion(.success(image))
        }
        completion(.failure(FileManagerErrors.errorWithGettingImage))
    }
}
