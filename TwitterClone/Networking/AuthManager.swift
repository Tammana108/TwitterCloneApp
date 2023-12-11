//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 07/12/23.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

class AuthManager {
    static let shared = AuthManager()
    
    
    func registerUser(with email : String, password : String) -> AnyPublisher<User, Error> {
        let subject = PassthroughSubject<User, Error>()

           Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
               if let error = error {
                   subject.send(completion: .failure(error))
               } else if let user = authResult?.user {
                   subject.send(user)
                   subject.send(completion: .finished)
               } else {
                   // Handle unexpected case
                  // subject.send(completion: .failure(YourErrorType.unknownError))
               }
           }

           return subject.eraseToAnyPublisher()
    }
    
    func loginUser(with email : String, password : String) -> AnyPublisher<User, Error> {
        let subject = PassthroughSubject<User, Error>()
        
           Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
               if let error = error {
                   subject.send(completion: .failure(error))
               } else if let user = authResult?.user {
                   subject.send(user)
                   subject.send(completion: .finished)
               } else {
                   // Handle unexpected case
                  // subject.send(completion: .failure(YourErrorType.unknownError))
               }
           }

           return subject.eraseToAnyPublisher()
    }
    private init(){
        
    }
}
