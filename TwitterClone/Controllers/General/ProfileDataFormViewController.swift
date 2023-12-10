//
//  ProfileDataFormViewController.swift
//  TwitterClone
//
//  Created by Tammana Sharma on 07/12/23.
//

import UIKit
import PhotosUI
import Combine

class ProfileDataFormViewController: UIViewController {
    
    private let viewModel = ProfileDataFormViewViewModel()
    private var subscriptions : Set<AnyCancellable> = []
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.text = "Fill in your data"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarPlaceholderImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 60
        imageView.backgroundColor = .lightGray
        imageView.tintColor = .gray
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let displayNameField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemFill
        textField.keyboardType = .default
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        return textField
    }()
    
    private let userNameField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemFill
        textField.keyboardType = .default
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        return textField
    }()
    
    private let bioTextView : UITextView = {
        let textView = UITextView()
        textView.text = "Tell the world about yourself"
        textView.backgroundColor = .secondarySystemFill
        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .gray
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let submitButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 28
        button.isEnabled = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        isModalInPresentation = true
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(avatarPlaceholderImageView)
        scrollView.addSubview(displayNameField)
        scrollView.addSubview(userNameField)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(submitButton)
        configureConstraints()
        displayNameField.delegate = self
        userNameField.delegate = self
        bioTextView.delegate = self
        bindView()
        avatarPlaceholderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUploadPhoto)))
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDismiss)))
    }
    
    @objc func didTapSubmitButton() {
        viewModel.uploadAvatar()
    }
    
    @objc func didTapDismiss() {
        view.endEditing(true)
    }
    
    @objc private func didTapUploadPhoto(){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    @objc private func didUpdateDisplayName(){
        viewModel.displayName = displayNameField.text
        viewModel.validateProfileDataForm()
    }
    @objc private func didUpdateUserName(){
        viewModel.userName = userNameField.text
        viewModel.validateProfileDataForm()
    }
    
    func bindView(){
        displayNameField.addTarget(self, action: #selector(didUpdateDisplayName), for: .editingChanged)
        userNameField.addTarget(self, action: #selector(didUpdateUserName), for: .editingChanged)
        
        viewModel.$isProfileDataFormValid.sink {[weak self] validationStatus in
            self?.submitButton.isEnabled = validationStatus
        }
        .store(in: &subscriptions)
        
        viewModel.$isOnboardingFinished.sink {[weak self] status in
            if status {
                self?.dismiss(animated: true)
            }
        }
        .store(in: &subscriptions)
    }
    
    private func configureConstraints(){
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
        ]
        
        let avatarPlaceholderImageViewConstraints = [
            avatarPlaceholderImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            avatarPlaceholderImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarPlaceholderImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarPlaceholderImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]
        
        let displayNameTextFieldConstraints = [
            displayNameField.topAnchor.constraint(equalTo: avatarPlaceholderImageView.bottomAnchor, constant: 20),
            displayNameField.heightAnchor.constraint(equalToConstant: 50),
            displayNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let userNameTextFieldConstraints = [
            userNameField.topAnchor.constraint(equalTo: displayNameField.bottomAnchor, constant: 20),
            userNameField.heightAnchor.constraint(equalToConstant: 50),
            userNameField.leadingAnchor.constraint(equalTo: displayNameField.leadingAnchor),
            userNameField.trailingAnchor.constraint(equalTo: displayNameField.trailingAnchor)
        ]
        
        let bioTextViewConstraints = [
            bioTextView.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 20),
            bioTextView.heightAnchor.constraint(equalToConstant: 150),
            bioTextView.leadingAnchor.constraint(equalTo: displayNameField.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: displayNameField.trailingAnchor)
        ]
        
        let submitButtonConstraints = [
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor , constant: -20)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(avatarPlaceholderImageViewConstraints)
        NSLayoutConstraint.activate(displayNameTextFieldConstraints)
        NSLayoutConstraint.activate(userNameTextFieldConstraints)
        NSLayoutConstraint.activate(bioTextViewConstraints)
        NSLayoutConstraint.activate(submitButtonConstraints)
    }


}

extension ProfileDataFormViewController : UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
     
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray{
            textView.textColor = .label
            textView.text = ""
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 100), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .gray
            textView.text = "Tell the world about yourself"
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.bio = bioTextView.text
        viewModel.validateProfileDataForm()
    }
}

extension ProfileDataFormViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self]data, error in
                if let image = data as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarPlaceholderImageView.image = image
                        self?.viewModel.image = image
                        self?.viewModel.validateProfileDataForm()
                    }
                }
            }
        }
    }
    
    
}
