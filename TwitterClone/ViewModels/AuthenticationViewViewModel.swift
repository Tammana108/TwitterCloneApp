//
//  AuthenticationViewViewModel.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 07/12/23.
//

import Foundation
import Firebase
import Combine

final class AuthenticationViewViewModel : ObservableObject {
    @Published var email : String?
    @Published var password : String?
    @Published var isAuthenticationFormValid : Bool = false
    @Published var user : User?
    @Published var error : String?
    private var subscriptions : Set<AnyCancellable> = []
    
    func validateRegistrationForm() {
        guard let email = email,let password = password else{
            isAuthenticationFormValid = false
            return
        }
        isAuthenticationFormValid = isValidEmail(email) && password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func registerUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.registerUser(with: email, password: password)
            .handleEvents(receiveOutput: { user in
                self.user = user
            })
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
                
            } receiveValue: { [weak self] user in
                self?.createRecord(from: user)
            }
            .store(in: &subscriptions)

    }
    
    func createRecord(from user : User){
        DatabaseManager.shared.collectionUser(from: user)
            .sink { completion in
                
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
                
            } receiveValue: { status in
                print("Create user status", status)
            }
            .store(in: &subscriptions)

    }
    
    func loginUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.loginUser(with: email, password: password)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
                
            } receiveValue: { user in
                self.user = user
            }
            .store(in: &subscriptions)

    }
}
