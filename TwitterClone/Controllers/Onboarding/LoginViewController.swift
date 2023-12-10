//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 07/12/23.
//

import Foundation
import UIKit
import Combine

class LoginViewController: UIViewController {
    private let viewModel = AuthenticationViewViewModel()
    private var subscriptions : Set<AnyCancellable> = []
    
    private let loginTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Login to your account"
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray
        ])
        textField.backgroundColor = .lightGray
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray
        ])
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginAccountButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Login Account", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 28
        button.isEnabled = false
        button.backgroundColor = .tweetBackgroundColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(loginTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginAccountButton)
        
        configureConstraints()
        bindValues()
        let emailTextFieldPaddingView = UIView(frame: CGRectMake(0, 0, 15, emailTextField.frame.height))
        emailTextField.leftView = emailTextFieldPaddingView
        emailTextField.leftViewMode = UITextField.ViewMode.always
        let passwordTextFieldPaddingView = UIView(frame: CGRectMake(0, 0, 15, passwordTextField.frame.height))
        passwordTextField.leftView = passwordTextFieldPaddingView
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDismiss)))
    }
    @objc func didTapDismiss(){
        view.endEditing(true)
    }
    
    @objc func didTapEmailField(){
        viewModel.email = emailTextField.text
        viewModel.validateRegistrationForm()
        
    }
    
    @objc func didTapPasswordField(){
        viewModel.password = passwordTextField.text
        viewModel.validateRegistrationForm()
    }
    
    @objc func didTapLoginAccount(){
        viewModel.loginUser()
    }
    
    func bindValues() {
        emailTextField.addTarget(self, action: #selector(didTapEmailField), for: .allEditingEvents)
        passwordTextField.addTarget(self, action: #selector(didTapPasswordField), for: .allEditingEvents)
        loginAccountButton.addTarget(self, action: #selector(didTapLoginAccount), for: .touchUpInside)
        viewModel.$isAuthenticationFormValid.sink {[weak self] validationState in
            self?.loginAccountButton.isEnabled = validationState
        }
        .store(in: &subscriptions)
        
        viewModel.$user.sink {[weak self] user in
            guard user != nil else { return }
            guard let vc = self?.navigationController?.viewControllers.first as? OnboardingViewController else { return }
            vc.dismiss(animated: true)
        }
        .store(in: &subscriptions)
        
        viewModel.$error.sink { [weak self] error in
            guard let error = error else { return }
            self?.presentFailureAlert(with: error)
        }
        .store(in: &subscriptions)

    }
    
    func presentFailureAlert(with error : String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func configureConstraints() {
        let loginTitleLabelConstraints = [
            loginTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ]
        
        let emailTextFieldConstraints = [
            emailTextField.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor , constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor , constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let loginAccountButtonConstraints = [
            loginAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginAccountButton.heightAnchor.constraint(equalToConstant: 55),
            loginAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            
        ]
        
        NSLayoutConstraint.activate(loginTitleLabelConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(loginAccountButtonConstraints)
    }
    
}
