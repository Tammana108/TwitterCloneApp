//
//  HomeViewViewModel.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 07/12/23.
//

import Foundation
import Combine
import FirebaseAuth

final class HomeViewViewModel : ObservableObject {
    
    @Published var user : TwitterUser?
    @Published var error : String?
    @Published var tweets : [Tweet] = []
    
    private var subscriptions : Set<AnyCancellable> = []
    
    func retrieveUser(){
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionUser(retrieve: id)
            .handleEvents(receiveOutput: {[weak self] user in
                self?.user = user
                self?.fetchTweets()
            })
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
                
            } receiveValue: {[weak self] user in
                //self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    func fetchTweets(){
        guard let userID = user?.id else { return }
        DatabaseManager.shared.collectionTweets(retrieveTweets: userID)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
            } receiveValue: { [weak self] retreivedTweets in
                self?.tweets = retreivedTweets
            }
            .store(in: &subscriptions)

    }
}
