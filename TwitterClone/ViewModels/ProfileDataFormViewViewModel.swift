//
//  ProfileDataFormViewViewModel.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 08/12/23.
//

import Foundation
import UIKit
import FirebaseStorage
import Combine
import FirebaseAuth

final class ProfileDataFormViewViewModel : ObservableObject {
    @Published var displayName : String?
    @Published var userName : String?
    @Published var bio : String?
    @Published var avatarPath : String?
    @Published var image : UIImage?
    @Published var isProfileDataFormValid : Bool = false
    @Published var error : String = ""
    @Published var isOnboardingFinished : Bool = false
    private var subscriptions : Set<AnyCancellable> = []
    
    func validateProfileDataForm() {
        guard let displayName = displayName, displayName.count > 2,let userName = userName , userName.count > 2, let bio = bio, bio.count > 2, image != nil else {
            isProfileDataFormValid = false
            return
        }
        isProfileDataFormValid = true
            
    }
    
    func uploadAvatar() {
        let randomID = UUID().uuidString
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        StorageManager.shared.uploadProfilePhoto(with: randomID, image: imageData, metaData: metaData)
            .flatMap({ metaData in
                StorageManager.shared.getDownloadURL(for: metaData.path)
            })
            .sink { [weak self] completion in
                switch completion {
                case .finished :
                    self?.updateUserData()
                case .failure(let error) :
                    self?.error = error.localizedDescription
                }
            } receiveValue: { url in
                self.avatarPath = url.absoluteString
            }
            .store(in: &subscriptions)
    }
    
    func updateUserData() {
        guard let displayName,
              let userName,
              let bio,
              let avatarPath,
              let id = Auth.auth().currentUser?.uid else { return }
              
        let updateFields : [String : Any] = [
            "displayName" : displayName,
            "userName" : userName,
            "bio" : bio,
            "avatarPath" : avatarPath,
            "isUserOnboard" : true
        ]
        
        DatabaseManager.shared.collectionUser(updateFields: updateFields, for: id)
            .sink {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { onboardingStatus in
                self.isOnboardingFinished = onboardingStatus
            }
            .store(in: &subscriptions)

              
    }
    
}
