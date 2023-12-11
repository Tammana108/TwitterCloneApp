//
//  DatabaseManager.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 07/12/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
    static let shared = DatabaseManager()
    let db = Firestore.firestore()
    let usersPath : String = "users"
    let tweetsPath : String = "tweets"
    
    
    func collectionUser(from user : User) -> AnyPublisher<Bool, Error>{
        let twitterUser = TwitterUser(from: user)
        let twitterUserDictionary = (try? twitterUser.toDictionary()) ?? [:]
        let subject = PassthroughSubject<Bool, Error>()
        db.collection(usersPath).document(twitterUser.id).setData(twitterUserDictionary) { error in
                if let error = error {
                    subject.send(completion: .failure(error))
                } else {
                    subject.send(true)
                    subject.send(completion: .finished)
                }
            }
       

            return subject.eraseToAnyPublisher()
    }
    func collectionUser(retrieve id: String) -> AnyPublisher<TwitterUser, Error> {
        return Future { promise in
            self.db.collection(self.usersPath).document(id).getDocument { document, error in
                if let error = error {
                    promise(.failure(error))
                } else if let document = document, document.exists {
                    do {
                        if let twitterUserData = document.data() {
                            let jsonData = try JSONSerialization.data(withJSONObject: twitterUserData)
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            let twitterUser = try decoder.decode(TwitterUser.self, from: jsonData)
                            promise(.success(twitterUser))
                        }
                    } catch {
                        promise(.failure(error))
                    }
                } else {
                    let customError = NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
                    promise(.failure(customError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func collectionUser(updateFields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
        return Future {promise in
            self.db.collection(self.usersPath)
                .document(id)
                .updateData(updateFields) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(true))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func collectionTweets(dispatch tweet : Tweet) -> AnyPublisher<Bool, Error> {
        return Future {promise in
            
            try? self.db.collection(self.tweetsPath)
                .document(tweet.id)
                .setData(from : tweet) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(true))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func collectionTweets(retrieveTweets forUserID: String) -> AnyPublisher<[Tweet], Error> {
        self.db.collection(tweetsPath).whereField("authorId", isEqualTo: forUserID)
                .getDocuments()
                .tryMap { querySnapshot -> [Tweet] in
                    let tweets = try querySnapshot.documents.compactMap { document -> Tweet? in
                        try document.data(as: Tweet.self)
                    }
                    return tweets
                }
                .eraseToAnyPublisher()
    }
    
    private init(){
        
    }
}
