//
//  TweetComposeViewViewModel.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 10/12/23.
//

import Foundation
import Combine
import FirebaseAuth


final class TweetComposeViewViewModel : ObservableObject {
    private var subscriptions : Set<AnyCancellable> = []
    private var user : TwitterUser?
    var tweetContent : String = ""
    @Published private var error : String?
    @Published var isValidToTweet : Bool = false
    @Published var shouldDismissComposer : Bool = false
    
    
    func getUserData(){
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
    
    func validateToTweet() {
        isValidToTweet = !tweetContent.isEmpty
    }
    
    func dispatchTweet() {
        guard let user = user else { return }
        
        let tweet = Tweet(author: user, authorId: user.id, tweetContent: tweetContent , likesCount: 0, likers: [], isReply: false, parentReference: nil)
        
        DatabaseManager.shared.collectionTweets(dispatch: tweet)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
            } receiveValue: { [weak self] status in
                self?.shouldDismissComposer = status
            }
            .store(in: &subscriptions)

    }
}
