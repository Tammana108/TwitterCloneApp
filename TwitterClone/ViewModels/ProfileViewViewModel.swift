//
//  ProfileViewViewModel.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 09/12/23.
//

import Foundation
import Combine
import FirebaseAuth

final class ProfileViewViewModel : ObservableObject {
    @Published var user : TwitterUser?
    @Published var error : String?
    private var subscriptions : Set<AnyCancellable> = []
    
    func retrieveUser(){
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionUser(retrieve: id)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
                
            } receiveValue: {[weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)

    }
}
