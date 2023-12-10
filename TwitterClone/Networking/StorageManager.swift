//
//  StorageManager.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 09/12/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseStorageCombineSwift
import Combine

enum FirebaseStorageError : Error {
    case invalidImageID
}
class StorageManager {
    static let shared = StorageManager()
    
    let storage = Storage.storage()
    
    private init() {
    }
    
    func getDownloadURL(for id : String?) -> AnyPublisher<URL, Error> {
        guard let id = id else {
            return Fail(error: FirebaseStorageError.invalidImageID)
                .eraseToAnyPublisher()
        }
        
        return storage.reference(withPath: id)
            .downloadURL()
            .print()
            .eraseToAnyPublisher()
        
    }
    
    func uploadProfilePhoto(with randomID: String, image : Data, metaData : StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .reference()
            .child("images/\(randomID).jpg")
            .putData(image, metadata: metaData)
            .eraseToAnyPublisher()
    }
    
    
}
