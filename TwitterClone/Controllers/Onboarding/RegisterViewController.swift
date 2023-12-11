//
//  RegisterViewController.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 07/12/23.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    
    private let viewModel = AuthenticationViewViewModel()
    private var subscriptions : Set<AnyCancellable> = []
    
    private let registerTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Create your account"
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
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
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
    
    private let createAccountButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Create Account", for: .normal)
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
        view.addSubview(registerTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)
        
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
    
    @objc func didTapCreateAccount(){
        viewModel.registerUser()
    }
    
    func bindValues() {
        emailTextField.addTarget(self, action: #selector(didTapEmailField), for: .allEditingEvents)
        passwordTextField.addTarget(self, action: #selector(didTapPasswordField), for: .allEditingEvents)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        viewModel.$isAuthenticationFormValid.sink {[weak self] validationState in
            self?.createAccountButton.isEnabled = validationState
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
        let registerTitleLabelConstraints = [
            registerTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ]
        
        let emailTextFieldConstraints = [
            emailTextField.topAnchor.constraint(equalTo: registerTitleLabel.bottomAnchor , constant: 30),
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
        
        let createAccountButtonConstraints = [
            createAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 55),
            createAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            
        ]
        
        NSLayoutConstraint.activate(registerTitleLabelConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(createAccountButtonConstraints)
    }
}
